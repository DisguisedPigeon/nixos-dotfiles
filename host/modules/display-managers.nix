{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.hyprland.xwayland.enable = true;
  programs.niri.package = pkgs.niri-stable;

  security.pam.services.hyprlock = { };

  environment.systemPackages = lib.mkIf config.programs.niri.enable [
    pkgs.xwayland-satellite
  ];
}
