cc := clang

all: https_lib bd_exec

https_lib: ml-req.c https.ml
	$(cc) -c -I`ocamlc -where` ml-req.c
	ocamlopt -c https.ml

json_lib: json.mly
	ocamlyacc json.mly

bd_exec: bd.ml https.cmx https.cmi ml-req.o
	ocamlopt -o bd https.cmx bd.ml ml-req.o -ccopt -Lcurl -cclib -lcurl

clean_aux:
	rm -f *.[oa] *.so *.cm[ixoa] *.cmxa

.PHONY: stdal https_lib bd_exec clean_aux
