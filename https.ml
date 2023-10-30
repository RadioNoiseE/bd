(*
 * Https module (interface) for the program bd.
 * Copyright 2023, Jing Huang.
 * Licensed MIT.
 *)

external ml_request: string -> string -> string -> string = "ocaml_request"
external ml_fetch: string -> string -> string -> string -> string = "ocaml_fetch"

exception Unexpected_return_value

type data_desc = { url: string; referer: string }
type resource_desc = { url: string; referer: string; filename: string }
type record =
  | Data of data_desc
  | Resource of resource_desc

let transfer record cookie =
  let responce = match record with
    | Data { url; referer } ->
      ml_request url referer cookie
    | Resource { url; referer; filename } ->
      ml_fetch url referer cookie filename
  in (if responce <> "" then responce else raise Unexpected_return_value);;
