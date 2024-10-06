# Graphic environment-related options

{ config, lib, ... }:
{
  imports = [
    ./hyprland.nix
    ./plasma.nix
    ./awesome.nix
  ];

  options = {
      graphics.enable = lib.mkEnableOption "graphics";
      graphics.desktops = {
        hyprland = lib.mkEnableOption "hyprland desktop";
        plasma = lib.mkEnableOption "plasma desktop";
        awesome= lib.mkEnableOption "awesome desktop";
      };
    };

  config = let
        opts = config.graphics; in lib.mkIf opts.enable {
      services = {
        xserver = {
          enable = true;
          xkb.layout = "es";
        };

        pipewire = {
          enable = true;
          pulse.enable = true;
          alsa.enable = true;
        };

        libinput.enable = true;
        displayManager.sddm.enable = true;
      };
    };
}
