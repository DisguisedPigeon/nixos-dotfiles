{ inputs, ... }:
let
  wrapped-mango = ../../../packages/wrapped-mango.nix;
in
{
  flake-file.inputs.wrappers = {
    url = "github:BirdeeHub/nix-wrapper-modules";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  perSystem =
    { pkgs, ... }:
    {
      packages.mango-custom = pkgs.callPackage wrapped-mango { inherit inputs; };
    };

  flake.aspects.mango.nixos =
    { pkgs, config, ... }:
    {
      xdg.portal = {
        extraPortals = with pkgs; [
          xdg-desktop-portal
          xdg-desktop-portal-gtk
          xdg-desktop-portal-wlr
          gnome-keyring
        ];
      };

      programs.mangowc = {
        enable = true;
        package = pkgs.callPackage wrapped-mango { inherit config inputs; };
      };
    };
}
