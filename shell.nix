with import <nixpkgs> {};
stdenv.mkDerivation rec {
  name="env";
  buildInputs = [
    stow
  ];
}
