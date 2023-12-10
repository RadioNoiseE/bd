(*
 * URL parser for the program bd.
 * Copyright 2023, Jing Huang.
 * Licensed MIT.
 *)

type t = Url_datatype.stt

open Url_datatype

let parse (link: string): t =
  let lexbuf = Lexing.from_string link in
  Url_parser.main Url_lexer.token lexbuf
;;

let cat (link: string): t =
  let target = parse link in
  match target.favour with
  | "avid" -> { site = target.site; cnt = target.cnt; favour = "aid"; id = target.id }
  | _ -> target
;;
