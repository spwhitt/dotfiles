{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  pname = "ww-run-raise";
  version = "";

  src = fetchFromGitHub {
    owner = "academo";
    repo = "ww-run-raise";
    rev = "af5a559a63873eb1810acf1069844c72fa3f28f6";
    sha256 = "sha256-LEbVUrf6rdR8mBVXaaesXlvl8QbV+q7tL6RBoGzxA6A=";
  };

  doConfigure = false;
  doBuild = false;
  doCheck = false;

  installPhase = ''
    mkdir -p $out/bin
    cp ./ww $out/bin
  '';
}
