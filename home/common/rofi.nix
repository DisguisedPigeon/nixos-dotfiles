{ pkgs, ... }:
{
  home.packages = [ pkgs.rofi ];

  xdg.configFile.rofi = {
    enable = true;
    source = ./configs/rofi;
    recursive = true;
  };
}
