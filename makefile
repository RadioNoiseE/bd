# Makefile for the program bd.
# Copyright 2023, Jing Huang.
# Licensed MIT

cc := clang

all: https_lib json_lib bd_exec

https_lib: ml-req.c https.ml
	$(cc) -c -I`ocamlc -where` ml-req.c
	ocamlopt -c https.ml

json_lib: json_lexer.mll json_parser.mly
	ocamllex json_lexer.mll
	ocamlyacc json_parser.mly
	ocamlopt -c json_datatype.ml
	ocamlopt -c json_parser.mli
	ocamlopt -c json_lexer.ml
	ocamlopt -c json_parser.ml
	ocamlopt -c json.ml

bd_exec: bd.ml https.cmx https.cmi ml-req.o
	ocamlopt -o bd https.cmx json_lexer.cmx json_parser.cmx  json.cmx bd.ml ml-req.o -ccopt -Lcurl -cclib -lcurl

clean_aux:
	rm -f *.[oa] *.so *.cm[ixoa] *.cmxa json_lexer.ml json_parser.ml json_parser.mli

.PHONY: https_lib json_lib bd_exec clean_aux
