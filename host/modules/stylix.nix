# Stylix config (probably not the best way to do this)
{ pkgs, ... }:
{
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    # base16Scheme = lib.mkDefault {
    #   system = "base16";
    #   name = "duskfox";
    #   slug = "duskfox";
    #   author = "EdenEast";
    #   description = "a short description of the scheme";
    #   variant = "'light' or 'dark'";
    #   palette = {
    #     base00 = "232136";
    #     base01 = "2d2a45";
    #     base02 = "373354";
    #     base03 = "47407d";
    #     base04 = "6e6a86";
    #     base05 = "e0def4";
    #     base06 = "cdcbe0";
    #     base07 = "e2e0f7";
    #     base08 = "eb6f92";
    #     base09 = "ea9a97";
    #     base0A = "f6c177";
    #     base0B = "a3be8c";
    #     base0C = "9ccfd8";
    #     base0D = "569fba";
    #     base0E = "c4a7e7";
    #     base0F = "eb98c3";
    #   };
    # };
    image = ./configs/wallpaper.png;
    cursor.package = pkgs.banana-cursor;
    cursor.name = "Banana";
    fonts = {
      monospace = {
        package = pkgs.maple-mono-NF;
        name = "Maple Mono NF";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
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
