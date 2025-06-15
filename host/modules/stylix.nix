{ pkgs, ... }:
{
  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

    polarity = "dark";

    cursor = {
      package = pkgs.banana-cursor;
      name = "Banana";
      size = 22;
    };

    fonts = {
      serif = {
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF";
      };
      sansSerif = {
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF";
      };
      monospace = {
        package = pkgs.maple-mono.NF;
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
  };
}
