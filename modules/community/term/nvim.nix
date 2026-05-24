{ inputs, ... }:
let
  wrapped-nvim = pkgs: pkgs.callPackage ../../../packages/wrapped-nvim.nix { inherit inputs; };
in
{
  flake-file.inputs.wrappers = {
    url = "github:BirdeeHub/nix-wrapper-modules";
  };

  perSystem =
    { pkgs, ... }:
    {
      packages.neovim-custom = wrapped-nvim pkgs;
    };

  flake.aspects.nvim.nixos =
    { pkgs, ... }:
    {
      programs.neovim = {
        enable = true;
        package = wrapped-nvim pkgs;
        viAlias = true;
        vimAlias = true;
      };
    };
}
