{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    bind = [ "$mod, F, exec, firefox" ];
  };
}
