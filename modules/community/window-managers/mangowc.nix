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
        extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
        config.wlr.default = [
          "wlr"
          "gtk"
        ];
      };

      programs.mangowc = {
        enable = true;
        package = pkgs.callPackage wrapped-mango { inherit config inputs; };
      };
    };
}
