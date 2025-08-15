{ pkgs, ... }:
let
  wallpaper-location = "sddm-wallpaper.png";
  sddm-astronaut-pkg = pkgs.callPackage ./sddm-astronaut-theme.nix {
    theme = "astronaut";
    themeConfig = {
      General = {
        HeaderText = "Hi";
        FontSize = "10.0";
        Background = "/etc/${wallpaper-location}";
      };
    };
  };
in
{
  environment.etc.${wallpaper-location}.source = ../../shared-files/wallpaper.png;

  environment.systemPackages = [
    pkgs.xwayland-satellite
    sddm-astronaut-pkg
    pkgs.banana-cursor
    pkgs.kdePackages.sddm-kcm
  ];

  services = {
    libinput.enable = true;
    pipewire.enable = true;

    displayManager.sddm.enable = true;
    displayManager.defaultSession = "hyprland";

    pipewire = {
      pulse.enable = true;
      alsa.enable = true;
    };

    displayManager.sddm = {
      wayland.enable = true;

      theme = "sddm-astronaut-theme";

      package = pkgs.kdePackages.sddm;

      extraPackages = with pkgs.kdePackages; [
        qtmultimedia
        qtsvg
        qtvirtualkeyboard
      ];
    };
  };
  security.pam.services.hyprlock = { };

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    hyprlock.enable = true;
  };
  programs.niri.enable = true;
  programs.niri.package = pkgs.niri-stable;
}
