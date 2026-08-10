{ inputs, ... }:
let
  mango-wrap = ../../../packages/wrapped-mango.nix;
in
{
  flake-file.inputs = {
    wrappers.url = "github:BirdeeHub/nix-wrapper-modules";
  };

  perSystem =
    { pkgs, ... }:
    {
      packages.mango-custom = pkgs.callPackage mango-wrap { inherit inputs; };
    };

  flake.aspects.mangowm.nixos =
    { pkgs, config, ... }:
    {
      xdg.portal.extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
        gnome-keyring
      ];

      programs.mango = {
        enable = true;
        package = pkgs.callPackage mango-wrap { inherit inputs config; };
      };
    };
}
