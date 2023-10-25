/* 
 * Request C module for the program bd.
 * Copyright 2023, Jing Huang.
 * Licensed MIT.
 */

# include <stdio.h>
# include <stdlib.h>
# include <string.h>
# include <caml/mlvalues.h>
# include <caml/alloc.h>
# include <curl/curl.h>

struct mem_struct {
  char *memory;
  size_t size;
};

static size_t
write_string_callback(void *contents, size_t size, size_t nmemb, void *userp)
{
  size_t realsize = size * nmemb;
  struct mem_struct *mem = (struct mem_struct *)userp;
  char *ptr = realloc(mem->memory, mem->size + realsize +1);
  if (!ptr) {
    printf("ml-req.c: not enough memory (realloc error).\n");
    return 0;
  }
  mem->memory = ptr;
  memcpy(&(mem->memory[mem->size]), contents, realsize);
  mem->size += realsize;
  mem->memory[mem->size] = 0;
  return realsize;
}

static size_t
write_file_callback(void *contents, size_t size, size_t nmemb, FILE *stream)
{
  size_t written = fwrite(contents, size, nmemb, stream);
  return written;
}

CAMLprim value
ocaml_request(value url, value referer, value cookie)
{
  CURL *flag = curl_easy_init();
  CURLcode res;
  struct mem_struct chunk;
  chunk.memory = malloc(1);
  if (chunk.memory == NULL) {
    printf("ml-req.c: not enough memory (malloc failed).\n");
    return caml_copy_string("");
  }
  chunk.size = 0;
  if (!flag) {
    printf("ml-req.c: libcurl request failed (initialize error).\n");
    return caml_copy_string("");
  }
  curl_easy_setopt(flag, CURLOPT_URL, String_val(url));
  curl_easy_setopt(flag, CURLOPT_REFERER, String_val(referer));
  curl_easy_setopt(flag, CURLOPT_USERAGENT, "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:42.0) Gecko/20100101 Firefox/42.0");
  curl_easy_setopt(flag, CURLOPT_COOKIE, String_val(cookie));
  curl_easy_setopt(flag, CURLOPT_WRITEFUNCTION, write_string_callback);
  curl_easy_setopt(flag, CURLOPT_WRITEDATA, (void *)&chunk);
  res = curl_easy_perform(flag);
  char str[chunk.size];
  if (res != CURLE_OK) {
    printf("ml-req.c: libcurl perform failed (%s).\n", curl_easy_strerror(res));
  } else {
    strcpy(str, chunk.memory);
  }
  curl_easy_cleanup(flag);
  free(chunk.memory);
  curl_global_cleanup();
  return caml_copy_string(str);
}

CAMLprim value
ocaml_fetch(value url, value referer, value cookie, value filename)
{
  CURL *flag = curl_easy_init();
  CURLcode res;
  FILE *fp;
  if (!flag) {
    printf("ml-req.c: libcurl request failed (initialize error).\n");
    return caml_copy_string("");
  }
  fp = fopen(String_val(filename), "wb");
  curl_easy_setopt(flag, CURLOPT_URL, String_val(url));
  curl_easy_setopt(flag, CURLOPT_REFERER, String_val(referer));
  curl_easy_setopt(flag, CURLOPT_USERAGENT, "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:42.0) Gecko/20100101 Firefox/42.0");
  curl_easy_setopt(flag, CURLOPT_COOKIE, String_val(cookie));
  curl_easy_setopt(flag, CURLOPT_WRITEFUNCTION, write_file_callback);
  curl_easy_setopt(flag, CURLOPT_WRITEDATA, fp);
  res = curl_easy_perform(flag);
  if (res != CURLE_OK) {
    printf("ml-req.c: libcurl perform failed (%s).\n", curl_easy_strerror(res));
  } else {
    fclose(fp);
  }
  curl_easy_cleanup(flag);
  curl_global_cleanup();
  return caml_copy_string(String_val(filename));
}
