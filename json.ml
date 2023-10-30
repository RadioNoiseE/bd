(*
 * JSON reader for the program bd.
 * Copyright 2023, Jing Huang.
 * Licensed MIT.
 *)

open Json_datatype

type t = Json_datatype.stt;;

let parse (json: string): t =
  let linebuf = Lexing.from_string json in
  Json_parser.main Json_lexer.token linebuf
;;

exception NotNumericValue
exception NotStringableValue
exception NotObject
exception NoObject

let as_number (nmr: t) =
  match nmr with
  | Float nmr -> nmr
  | Integer nmr -> float_of_int nmr
  | _ -> raise NotNumericValue
;;

let as_string (str: t) =
  match str with
  | String str -> str
  | _ -> raise NotStringableValue
;;

let rec get_child (obj: t) (vlu: string) =
  match obj with
  | Object ((vlu, expr) :: tl) -> expr
  | Object (hd :: tl) -> get_child (Object tl) vlu
  | Object ([]) -> raise NoObject
  | _ -> raise NotObject
;;
