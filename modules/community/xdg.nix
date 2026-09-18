{
  flake.aspects.xdg.nixos = { pkgs, ... }: {
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
        gnome-keyring
      ];
    };
  };
}
