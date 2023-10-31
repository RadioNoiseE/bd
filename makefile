# Makefile for the program bd.
# Copyright 2023, Jing Huang.
# Licensed MIT

cc := clang

all: https_lib json_lib url_lib bd_exec

https_lib: ml-req.c https.ml
	$(cc) -c -I`ocamlc -where` ml-req.c
	ocamlopt -c https.ml

json_lib: json_lexer.mll json_parser.mly json.ml json_datatype.ml
	ocamllex json_lexer.mll
	ocamlyacc json_parser.mly
	ocamlopt -c json_datatype.ml
	ocamlopt -c json_parser.mli
	ocamlopt -c json_lexer.ml
	ocamlopt -c json_parser.ml
	ocamlopt -c json.ml

url_lib: url_lexer.mll url_parser.mly url.ml url_datatype.ml
	ocamllex url_lexer.mll
	ocamlyacc url_parser.mly
	ocamlopt -c url_datatype.ml
	ocamlopt -c url_parser.mli
	ocamlopt -c url_lexer.ml
	ocamlopt -c url_parser.ml
	ocamlopt -c url.ml

bd_exec: bd.ml https.cmx https.cmi ml-req.o json_lexer.cmx json_parser.cmx json.cmx url_lexer.cmx url_parser.cmx url.cmx
	ocamlopt -o bd https.cmx json_lexer.cmx json_parser.cmx json.cmx url_lexer.cmx url_parser.cmx url.cmx bd.ml ml-req.o -ccopt -Lcurl -cclib -lcurl

clean_aux:
	rm -f *.[oa] *.so *.cm[ixoa] *.cmxa json_lexer.ml json_parser.ml json_parser.mli url_lexer.ml url_parser.ml url_parser.mli

.PHONY: https_lib json_lib url_lib bd_exec clean_aux
