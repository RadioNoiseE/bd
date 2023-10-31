type token =
  | IDENT of (string)
  | SCHEME
  | SRPL
  | REST
  | FVRFEST
  | FVRVIDO
  | FVRBNGM
  | PLYFLG
  | SSID
  | BVID
  | EPID
  | SLASH
  | QUESMARK
  | COLON
  | AMPERSAND
  | EQUAL
  | EOF

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Url_datatype.stt
