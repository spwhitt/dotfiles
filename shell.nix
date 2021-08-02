{ pkgs ? import <nixpkgs> { } }:
with pkgs;

mkShell {
  name = "env";
  buildInputs = [ stow ];
}

