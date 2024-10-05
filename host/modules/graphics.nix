# Graphic environment-related options

{ config, lib }:
{
  options = {
    graphics.enable = lib.mkEnableOption "enables graphics";
    graphics.desktops = lib.mkDefault [ "hyprland" ];
  };

  config =
    let
      opts = config.graphics;
      desktopConfig =
        DEs:
        lib.list.forEach DEs (
          DE:
          {
            "hyprland" = ./hyprland.nix;
            "plasma" = ./plasma.nix;
            "awesome" = ./awesome.nix;
          }
          ."${DE}"
        );
    in
    lib.mkIf opts.enable {
      imports = desktopConfig opts.desktops;

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
