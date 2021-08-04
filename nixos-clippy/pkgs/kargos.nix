{ stdenv, fetchFromGitHub, cmake, extra-cmake-modules, plasma-framework }:

stdenv.mkDerivation {
  pname = "kargos";
  version = "dev-b467";

  src = fetchFromGitHub {
    owner = "lipido";
    repo = "kargos";
    rev = "b4670d0b8fea14087e01b1037fe6c5f892dacde7";
    sha256 = "sha256-VyZ2fMUqH6PH+w3ZHzRFKx4nALXGwyef6LYvDWWGuKc=";
  };

  nativeBuildInputs = [ cmake extra-cmake-modules ];
  buildInputs = [ plasma-framework ];

  dontWrapQtApps = true;
}
