{ pkgs, ... }:
{
  home.packages = [ pkgs.rofi-wayland ];

  xdg.configFile.rofi = {
    enable = true;
    source = ./configs/rofi;
    recursive = true;
  };
}
