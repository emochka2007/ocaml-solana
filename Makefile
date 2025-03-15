build:
	dune build

run:
	dune exec solana_sdk

.setup-env: seput
	opam switch create solana_sdk 5.3.0;
	opam install ocaml-lsp-server odoc ocamlformat utop dune;

setup:
	opam switch solana_sdk;

clean:
	dune clean

start:
	dune fmt
	dune exec solana_sdk
