(*
 * URL parser for the program bd.
 * Copyright 2023, Jing Huang.
 * Licensed MIT.
 *)

type t = Url_datatype.stt

open Url_datatype

let parse_url (link: string): t =
  let lexbuf = Lexing.from_string link in
  Url_parser.main Url_lexer.token lexbuf
;;
