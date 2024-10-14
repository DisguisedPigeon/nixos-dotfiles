{
  pkgs,
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.hyprland-customization.enable {
    home.packages = with pkgs; [ rofi-wayland ];

    xdg.configFile.rofi = {
      enable = true;
      source = ./configs/rofi;
      recursive = true;
    };
  };
}
