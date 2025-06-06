# Stylix config (probably not the best way to do this)
{ pkgs, lib, ... }:
let
  theme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
in
{
  stylix = {
    base16Scheme = theme;
    cursor = {
      package = pkgs.banana-cursor;
      name = "Banana";
      size = 22;
    };
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      monospace = {
        package = pkgs.maple-mono-NF;
        name = "Maple Mono NF";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
    opacity = {
      applications = 1.0;
      terminal = 0.8;
      desktop = 1.0;
      popups = 1.0;
    };
    polarity = "dark";
  };
}
