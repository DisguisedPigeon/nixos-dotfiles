{ inputs, ... }:
let
  flake.modules.nixos.ui =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        pipewire
        sddm
        limine
        stylix
        networkmanager
      ];

      environment.systemPackages = [
        pkgs.xdg-desktop-portal-gtk
      ];

      xdg.portal = {
        enable = true;
        config = {
          common = {
            default = [ "gtk" ];
          };
          niri = {
            default = [
              "gnome"
              "gtk"
            ];
          };
          hyprland = {
            default = [
              "hyprland"
              "gtk"
            ];
          };
        };
        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
        ];
      };

      services = {
        libinput.enable = true;
        flatpak.enable = true;
      };
    };
in
{
  inherit flake;
}
