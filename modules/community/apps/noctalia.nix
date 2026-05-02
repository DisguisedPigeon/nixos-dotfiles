{ inputs, ... }:
let
  wrapped-noctalia = ../../../packages/wrapped-noctalia.nix;
in
{
  flake-file.inputs = {
    wrappers = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia-plugins = {
      url = "github:noctalia-dev/noctalia-plugins";
      flake = false;
    };
  };

  perSystem =
    { pkgs, ... }:
    {
      packages.noctalia-custom = pkgs.callPackage wrapped-noctalia { inherit inputs; };
    };

  flake.aspects.noctalia.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages =
        with pkgs;
        [
          pavucontrol
          wvkbd
          swappy
        ]
        ++ [ (pkgs.callPackage wrapped-noctalia { inherit inputs; }) ];
    };
}
