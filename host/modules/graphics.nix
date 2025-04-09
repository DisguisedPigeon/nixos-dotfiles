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
      environment.etc."sddm-wallpaper.png".source = ./sddm-wallpaper.png;

      environment.systemPackages = [
        (pkgs.callPackage ./sddm-astronaut-theme.nix {
          theme = "astronaut";
          themeConfig = {
            General = {
              HeaderText = "Hi";
              Background = "/etc/sddm-wallpaper.png";
              FontSize = "10.0";
            };
          };
        })
        pkgs.banana-cursor
        pkgs.kdePackages.sddm-kcm
      ];
      services = {
        xserver = {
          enable = true;
          xkb.layout = "us";
          xkb.variant = "intl";
          xkbOptions = "lv3:ralt_switch";
        };

        pipewire = {
          enable = true;
          pulse.enable = true;
          alsa.enable = true;
        };

        libinput.enable = true;
        displayManager.defaultSession = "hyprland";
        displayManager.sddm = {
          theme = "sddm-astronaut-theme";
          extraPackages = with pkgs; [
            kdePackages.qtmultimedia
            kdePackages.qtsvg
            kdePackages.qtvirtualkeyboard
          ];
          package = pkgs.kdePackages.sddm;
          wayland.enable = true;
          enable = true;
        };
      };
    };
}
