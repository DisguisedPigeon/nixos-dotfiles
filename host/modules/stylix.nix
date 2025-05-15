# Stylix config (probably not the best way to do this)
{ pkgs, lib, ... }:
let
  theme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
in
{
  stylix = {
    base16Scheme = theme;
    #base16Scheme = lib.mkDefault {
    #  system = "base16";
    #  name = "duskfox";
    #  slug = "duskfox";
    #  author = "EdenEast";
    #  description = "a short description of the scheme";
    #  variant = "'light' or 'dark'";
    #  palette = {
    #    base00 = "232136";
    #    base01 = "2d2a45";
    #    base02 = "373354";
    #    base03 = "47407d";
    #    base04 = "6e6a86";
    #    base05 = "e0def4";
    #    base06 = "cdcbe0";
    #    base07 = "e2e0f7";
    #    base08 = "eb6f92";
    #    base09 = "ea9a97";
    #    base0A = "f6c177";
    #    base0B = "a3be8c";
    #    base0C = "9ccfd8";
    #    base0D = "569fba";
    #    base0E = "c4a7e7";
    #    base0F = "eb98c3";
    #  };
    #};
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
