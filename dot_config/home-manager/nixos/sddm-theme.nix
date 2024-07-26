# sddm-theme.nix
{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = ./sddm-themes/sddm-sugar-dark;
  installPhase = ''
    mkdir -p $out
    cp -R $src/* $out/
   '';
}
