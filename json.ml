(*
 * JSON reader for the program bd.
 * Copyright 2023, Jing Huang.
 * Licensed MIT.
 *)

type t = Json_datatype.stt

open Json_datatype

let parse (json: string): t =
  let lexbuf = Lexing.from_string json in
  Json_parser.main Json_lexer.token lexbuf
;;

exception NotNumericValue
exception NotStringableValue
exception NotArray
exception NoElement
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

let rec get_mem (nmr: int) (arr: t) =
  match arr with
  | Array (elements) -> List.nth elements nmr
  | Array ([]) -> raise NoElement
  | _ -> raise NotArray
;;

let rec get_child (vlu: string) (obj: t) =
  match obj with
  | Object ((key, expr) :: tl) -> if key = vlu then expr else get_child vlu (Object tl)
  | Object ([]) -> raise NoObject
  | _ -> raise NotObject
;;
