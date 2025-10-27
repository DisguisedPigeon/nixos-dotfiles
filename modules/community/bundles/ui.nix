{ inputs, ... }:
let
  flake.modules.homeManager.ui.imports = with inputs.self.modules.homeManager; [
    git
    nvim
    tmux
    wezterm
    zsh
  ];
  flake.modules.nixos.ui =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        hyprland
        sddm
        limine
        stylix
        networkmanager
        shell
      ];

      environment.systemPackages = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.home-manager
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
