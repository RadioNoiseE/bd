(*
 * Https module (interface) for the program bd.
 * Copyright 2023, Jing Huang.
 * Licensed MIT.
 *)

external ml_request: string -> string -> string -> string = "ocaml_request"
external ml-fetch: string -> string -> string -> string -> string = "ocaml_fetch"
