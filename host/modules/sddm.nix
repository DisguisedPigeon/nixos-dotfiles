{ pkgs, ... }:
let
  wallpaper-location = "sddm-wallpaper.png";
  sddm-astronaut-pkg = pkgs.callPackage ./sddm-astronaut-theme-pkg.nix {
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
  environment.systemPackages = [ sddm-astronaut-pkg ];

  environment.etc.${wallpaper-location}.source = ../../shared-files/wallpaper.jpg;

  services = {
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
}
