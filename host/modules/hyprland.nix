{ lib, config, ... }:
{
  config = lib.mkIf (config.graphics.enable && config.graphics.desktops.hyprland) {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    programs.hyprlock.enable = true;
    security.pam.services.hyprlock = { };
  };
}
