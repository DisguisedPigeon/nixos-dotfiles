# Graphic environment-related options

{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hyprland.nix
    ./awesome.nix
  ];

  options = {
    graphics.enable = lib.mkEnableOption "graphics";
    graphics.desktops = {
      hyprland = lib.mkEnableOption "hyprland desktop";
      plasma = lib.mkEnableOption "plasma desktop";
      awesome = lib.mkEnableOption "awesome desktop";
    };
  };

  config =
    let
      opts = config.graphics;
    in
      lib.mkIf opts.enable {
        environment.systemPackages = [ 
          pkgs.sddm-chili-theme
          pkgs.banana-cursor
          pkgs.kdePackages.sddm-kcm
        ];
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
          displayManager.defaultSession = "hyprland";
          displayManager.sddm = {
            settings = {
              Theme = {
                CursorTheme = "Banana";
                Current = "chili";
              };
            };
            package = pkgs.libsForQt5.sddm;
            wayland.enable = true;
            enable = true;
          };
        };
      };
}
