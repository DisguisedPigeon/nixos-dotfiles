{ inputs, ... }:
let
  wrapped-nvim = ../../../packages/wrapped-nvim.nix;
in
{
  flake-file.inputs = {
    wrappers.url = "github:BirdeeHub/nix-wrapper-modules";
  };

  perSystem =
    { pkgs, ... }:
    {
      packages.neovim-custom = pkgs.callPackage wrapped-nvim { inherit inputs; };
    };

  flake.aspects.nvim.nixos =
    { pkgs, ... }:
    {
      programs.neovim = {
        enable = true;
        package = pkgs.callPackage wrapped-nvim { inherit inputs; };
      };
    };
}
