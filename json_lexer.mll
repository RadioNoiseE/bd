{
open Lexing
open Json_parser

exception SyntaxError of string

let next_line lexbuf =
  let pos = lexbuf.lex_curr_p in
  lexbuf.lex_curr_p <- {
    pos with pos_bol = lexbuf.lex_curr_p;
             pos_lnum = pos.pos_lnum + 1
  }
}

let itg = '-'? ['0'-'9'] ['0'-'9']*
let dgt = ['0'-'9']
let frac = '.' dgt*
let exp = ['e' 'E'] ['-' '+']? dgt+
let flt = dgt* frac? exp?
let white = [' ' '\t']+
let newline = '\r' |'\n' | '\r\n'

rule token =
  parse
  | white { token lexbuf }
  | "true" { TRUE }
  | "false" { FALSE }
  | "null" { NULL }
  | itg { INT (int_of_string (Lexing.lexme lexbuf)) }
  | flt { FLOAT (float_of_string (Lexing.lexme lexbuf)) }
  | '"' { read_string (Buffer.create 128) lexbuf }
  | '[' { LEFT_BRACK }
  | ']' { RIGHT_BRACK }
  | '{' { LEFT_BRACE }
  | '}' { RIGHT_BRACE }
  | ':' { COLON }
  | ',' { COMMA }
  | eof { EOF }
  | _ { raise (SyntaxError (Printf.sprintf "offset %d: unexpected character.\n" (Lexing.lexme_start lexbuf))) }
and read_string buf =
  parse
  | '"' { STRING (Buffer.contents buf) }
  | '\\' 'n' { Buffer.add_char buf '\n'; read_string buf lexbuf }
  | '\\' 'b' { Buffer.add_char buf '\b'; read_string buf lexbuf }
  | '\\' 'f' { Buffer.add_char buf '\012'; read_string buf lexbuf }
  | '\\' 'r' { Buffer.add_char buf '\r'; read_string buf lexbuf }
  | '\\' 't' { Buffer.add_char buf '\t'; read_string buf lexbuf }
  | '\\' '/' { Buffer.add_char buf '/'; read_string buf lexbuf }
  | '\\' '\\' { Buffer.add_char buf '\\'; read_string buf lexbuf }
  | [^ '"' '\\']+ { Buffer.add_char buf (Lexing.lexme lexbuf); read_string buf lexbuf }
  | _ { Buffer.add_char buf (Lexing.lexme lexbuf); read_string buf lexbuf }
  | eof { raise (SyntaxError (Printf.sprintf "offset %d: string terminated by EOF.\n" (Lexing.lexme_start lexbuf))) }
