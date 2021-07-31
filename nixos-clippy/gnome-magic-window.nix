{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  pname = "gnome-magic-window";
  version = "c3a4";

  src = fetchFromGitHub {
    owner = "adrienverge";
    repo = "gnome-magic-window";
    rev = "c3a4a3b4f0164008c2c1ff362bdab28b985c923c";
    sha256 = "sha256-9H2TtkA4g3bWWc8wI4T+EA+to3qBkHjlfIs99njNM2I=";
  };

  doConfigure = false;
  doBuild = false;
  doCheck = false;

  installPhase = ''
    mkdir -p $out/bin
    cp ./gnome-magic-window $out/bin
  '';
}

