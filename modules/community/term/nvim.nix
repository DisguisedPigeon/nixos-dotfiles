{ inputs, ... }:
let
  wrapped-nvim = ../../../packages/wrapped-nvim.nix;
in
{
  flake-file.inputs.wrappers = {
    url = "github:BirdeeHub/nix-wrapper-modules";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  perSystem =
    { pkgs, ... }:
    {
      packages.neovim-custom = pkgs.callPackage wrapped-nvim { inherit inputs; };
    };

  flake.modules.nixos.nvim =
    { pkgs, ... }:
    {
      programs.neovim = {
        enable = true;

        viAlias = true;
        vimAlias = true;

        package = pkgs.callPackage wrapped-nvim { inherit inputs; };
      };
    };
}
