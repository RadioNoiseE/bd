/*
 * JSON parsing garmmar definition fot the program bd.
 * Copyright 2023, Jing Huang.
 * Licensed MIT.
 */

%token <string> IDENT
%token SCHEME
%token SRPL
%token REST
%token FVRFEST
%token FVRVIDO
%token FVRBNGM
%token PLYFLG
%token SSID
%token BVID
%token EPID
%token SLASH
%token QUESMARK
%token COLON
%token AMPERSAND
%token EQUAL
%token EOF

%type <Url_datatype.stt> main
%start main
%{ open Url_datatype %}

%%

main:
  | url_hdr FVRFEST SLASH IDENT QUESMARK IDENT EQUAL url_id IDENT AMPERSAND REST EOF { { site = $1; cnt = "festival"; favour = $8; id = $9 } }
  | url_hdr FVRFEST SLASH IDENT QUESMARK IDENT EQUAL url_id IDENT EOF { { site = $1; cnt = "festival"; favour = $8; id = $9 } }
  | url_hdr FVRVIDO SLASH url_id IDENT SLASH QUESMARK REST EOF { { site = $1; cnt = "video"; favour = $4; id = $5 } }
  | url_hdr FVRVIDO SLASH url_id IDENT SLASH EOF { { site = $1; cnt = "video"; favour = $4; id = $5 } }
  | url_hdr FVRVIDO SLASH url_id IDENT EOF { { site = $1; cnt = "video"; favour = $4; id = $5 } }
  | url_hdr FVRBNGM SLASH PLYFLG SLASH url_id IDENT SLASH QUESMARK REST EOF { { site = $1; cnt = "episode"; favour = $6; id = $7 } }
  | url_hdr FVRBNGM SLASH PLYFLG SLASH url_id IDENT QUESMARK REST EOF { { site = $1; cnt = "episode"; favour = $6; id = $7 } }
  | url_hdr FVRBNGM SLASH PLYFLG SLASH url_id IDENT EOF { { site = $1; cnt = "episode";favour  = $6; id = $7 } }
  ;

url_hdr:
  | SCHEME IDENT SRPL SLASH { $2 }
  ;

url_id:
  | SSID { "ssid" }
  | BVID { "bvid" }
  | EPID { "epid" }
  ;
