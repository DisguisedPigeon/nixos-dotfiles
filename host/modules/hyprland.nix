{ lib, config, ... }:
{
  config = lib.mkIf (config.graphics.enable && config.graphics.desktops.hyprland) {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
