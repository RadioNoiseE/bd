/*
 * JSON parsing grammar definition for the program bd.
 * Copyright 2023, Jing Huang.
 * Licensed MIT.
 */

%token <int> INT
%token <float> FLOAT
%token <string> STRING
%token TRUE
%token FALSE
%token NULL
%token LEFT_BRACE
%token RIGHT_BRACE
%token LEFT_BRACK
%token RIGHT_BRACK
%token COLON
%token COMMA
%token EOF

%type <Json_datatype.stt> main
%start main
%{ open Json_datatype %}

%%

main:
  | expr EOF { $1 }
  ;

expr:
  | INT { Integer($1) }
  | FLOAT { Float($1) }
  | STRING { String($1) }
  | TRUE { Bool(true) }
  | FALSE { Bool(false) }
  | NULL { Null }
  | LEFT_BRACK array_values RIGHT_BRACK { Array($2) }
  | LEFT_BRACE object_fields RIGHT_BRACE { Object($2) }
  ;

array_values:
  | rev_array_values { List.rev($1) }
  ;

rev_array_values:
  | /* Null */ { [] }
  | rev_array_values COMMA expr { $3::$1 }
  ;

object_fields:
  | rev_object_fields { List.rev($1) }
  ;

rev_object_fields:
  | /* Null */ { [] }
  | rev_object_fields COMMA STRING COLON expr { ($3,$5)::$1 }
  | STRING COLON expr { [($1, $3)] }
  ;

/* Obsolete |=>
%token <int> INT
%token <float> FLOAT
%token <string> ID
%token <string> STRING
%token TRUE
%token FALSE
%token NULL
%token LEFT_BRACE
%token RIGHT_BRACE
%token LEFT_BRACK
%token RIGHT_BRACK
%token COLON
%token COMMA
%token EOF

%start <Json.value option> prog

%%

prog:
  | EOF { None }
  | vlu = value { Some val }
  ;

value:
  | LEFT_BRACE; obj = object_fields; RIGHT_BRACE { `Assoc obj }
  | LEFT_BRACK; vl = array_values; RIGHT_BRACK { `List vl }
  | str = STRING { `String str }
  | itg = INT { `Int itg }
  | flt = FLOAT { `Float flt }
  | TRUE { `Bool true }
  | FALSE { `Bool false }
  | NULL { `Null }
  ;

object_fields:
  | obj = rev_object_fields { List.rev obj }
  ;

rev_object_fields:
  | (* NULL *) { [] }
  | obj = rev_object_fields; COMMA; idt = ID; vlu = value { (idt, vlu) :: obj }
  ;

prog:
  | vlu = value { Some vlu }
  | EOF { None }
  ;

value:
  | LEFT_BRACE; obj = object_fields; RIGHT_BRACE { `Assoc obj }
  | LEFT_BRACK; vl = list_fields; RIGHT_BRACK { `List vl }
  | str = STRING { `String str }
  | itg = INT { `Int itg }
  | flt = FLOAT { `Float flt }
  | TRUE { `Bool true }
  | FALSE { `Bool false }
  | NULL { `Null }
  ;

object_fields:
  | obj = seperated_list(COMMA, object_field) { obj }
  ;

object_field:
  | idt = STRING; COLON; vlu = value; { (idt, vlu) }
  ;

list_fields:
  | vl = seperated_list(COMMA, value) { vl }
  ;
<=| */
