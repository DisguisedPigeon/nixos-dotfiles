{ stdenv, fetchzip }:
stdenv.mkDerivation {
  name = "arcadeclassic-font";

  src = fetchzip {
    url = "https://www.1001fonts.com/download/arcadeclassic.zip";
    sha256 = "sha256-dsSP1KH1sb2zRvYSTuRnVLr54WavjJhyn8+RPWQJWfw=";
    stripRoot = false;
  };

  installPhase = ''
    mkdir -p $out/share/fonts
    cp -R $src $out/share/fonts/opentype/
  '';

  meta.description = "Arcade-like font. Free for personal use.";
}
