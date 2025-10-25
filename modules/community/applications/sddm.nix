{
  flake.modules.nixos.sddm =
    { pkgs, ... }:
    let
      wallpaper-location = "sddm-wallpaper.png";
      sddm-astronaut-pkg = pkgs.callPackage ./_sddm-astronaut-theme-pkg.nix {
        theme = "astronaut";
        themeConfig = {
          General = {
            HeaderText = ":3";
            FontSize = "10.0";
            Background = "/etc/${wallpaper-location}";
          };
        };
      };
    in
    {
      environment.systemPackages = [ sddm-astronaut-pkg ];

      environment.etc.${wallpaper-location}.source = ../../../resources/wallpaper.jpeg;

      services = {
        displayManager.sddm = {
          enable = true;
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
    };
}
