{ inputs, ... }:
let
  flake.modules.homeManager.ui =
    { ... }:
    {
      imports = with inputs.self.modules.homeManager; [
        hyprland
        kde-connect
        starship
        tmux
        waybar
        hypridle
      ];
    };
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

      programs.zsh.enable = true;
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
