(*
 * Bilibili extracter for the program bd.
 * Copyright 2023, Jing Huang.
 * Licensed MIT.
 *)

exception UnsupportedSite

type target = {
  mutable cnt : string;
  mutable favour : string;
  mutable id : string;
  mutable referer : string;
  mutable cookie : string;
}

let tarinfo = { cnt = "nil"; favour = "nil"; id = "nil"; referer = "nil"; cookie = "nil" };;

open Url_datatype

let extract url cookie =
  let link = Url.cat url in
  if (String.lowercase_ascii link.site) <> "bilibili" then raise UnsupportedSite
  else tarinfo = { cnt = link.cnt; favour = link.favour; id = link.id; referer = url; cookie }
  match classify tarinfo with
  | "festival" -> extract_festival tarinfo
  | "video" -> extract_video tarinfo
  | "episode" -> extract_episode tarinfo
;;

let classify_redirect url =
  try Https.transfer (Data { url = "https://api.bilibili.com/x/web-interface/view?" ^ url.favour "=" ^ url.id; referer = url.referer }) url.cookie
    |> Json.parse |> Json.get_child "data" |> Json.get_child "redirect_url" |> Json.as_string
  with NoObject -> "video"
;;

let classify url =
  match url.cnt with
  | "festival" -> "festival"
  | "episode" -> "episode"
  | "video" -> if (classify_redirect url) <> "video" then "episode" else "video"
  | "watchlater" -> classify_redirect url
;;

let extract_festival url =

;;

let extract_video url =

;;

let extract_episode url =

;;
