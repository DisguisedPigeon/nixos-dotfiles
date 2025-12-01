let
  wallpaper-location = "sddm-wallpaper.png";

  flake.modules.nixos.sddm =
    { pkgs, ... }:
    {
      services.displayManager.sddm.enable = true;

      environment.systemPackages = with pkgs; [ sddm-astronaut ];

      environment.etc.${wallpaper-location}.source = ../../../resources/wallpaper.png;

      services.displayManager.sddm = {
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
in
{
  inherit flake;
}
