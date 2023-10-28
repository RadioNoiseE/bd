(*
 * JSON datatype declaration for the program bd.
 * Copyright 2023, Jing Huang.
 * Licensed MIT.
 *)

type stt =
  | Integer of int
  | Float of float
  | String of string
  | Array of stt list
  | Bool of bool
  | Object of (string * stt) list
  | Null

(* Obsolete |=>
type value =
  [ `Assoc of (string * value) list
  | `Bool of bool
  | `Float of float
  | `Int of int
  | `List of value list
  | `Null
  | `String of string ]
<=| *)
