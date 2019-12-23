{ pkgs ? import <nixpkgs> {},
  schedule ? builtins.fetchGit {
    url = "https://github.com/voc/36C3_schedule.git";
  },
}:

with pkgs;

stdenv.mkDerivation {
  name = "env";
  buildInputs = [
    libxslt
  ];
  src = ./.;
  patchPhase = ''
    cp ${schedule}/everything.schedule.xml .
  '';
  installPhase = ''
    mkdir $out
    cp -v ?.html $out/
  '';
}
