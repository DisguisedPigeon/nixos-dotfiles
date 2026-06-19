{ inputs, ... }:
{
  flake-file = {
    description = "DPigeon's NixOS Config";

    inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

      flake-file.url = "github:vic/flake-file";
      flake-aspects.url = "github:vic/flake-aspects";
      flake-parts.url = "github:hercules-ci/flake-parts";

    };
  };

  imports = [
    inputs.flake-file.flakeModules.dendritic
    inputs.flake-file.flakeModules.nix-auto-follow
    inputs.flake-aspects.flakeModule
  ];
}
