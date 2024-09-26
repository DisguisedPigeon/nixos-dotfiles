{ pkgs, ... }:
{
  home.packages = with pkgs; [ rofi-wayland ];

  xdg.configFile.rofi = {
    enable = true;
    source = ./configs/rofi;
    recursive = true;
  };
}
