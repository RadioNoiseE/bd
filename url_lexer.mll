(*
 * URL lexer for the program bd.
 * Copyright 2023, Jing Huang.
 * Licensed MIT.
 *)

{
open Lexing 
open Url_parser
}

let hdr = "https://www." | "https://" | "www." | ""
let srps = ".com" | ""
let ss = "ss" | "SS" | "sS" | "Ss"
let av = "av" | "AV" | "aV" | "Av"
let bv = "bv" | "BV" | "bV" | "Bv"
let ep = "ep" | "EP" | "eP" | "Ep"
let ident = ['a'-'z' 'A'-'Z' '0'-'9' '.' '-' '_']+
let white = [' ' '\t']+
let rest = ['a'-'z' 'A'-'Z' '0'-'9' '.' '-' '_' '/' '?' ':' '&' '=']*

rule token =
  parse
  | white { token lexbuf }
  | ident { IDENT (Lexing.lexeme lexbuf) }
  | hdr { SCHEME }
  | srps { SRPL }
  | rest { REST }
  | "festival" { FVRFEST }
  | "video" { FVRVIDO }
  | "bangumi" { FVRBNGM }
  | "play" { PLYFLG }
  | "watchlater" { WCHLTR }
  | ss { SSID }
  | av { AVID }
  | bv { BVID }
  | ep { EPID }
  | '/' { SLASH }
  | '?' { QUESMARK }
  | ':' { COLON }
  | '&' { AMPERSAND }
  | '#' { HASH }
  | '=' { EQUAL }
  | eof { EOF }
