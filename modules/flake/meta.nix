{ inputs, ... }:
{
  flake-file = {
    description = "DPigeon's NixOS Config";

    inputs = {
      # Nixpkgs version
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

      # Dependency declaration and dendritic pattern
      flake-file.url = "github:vic/flake-file";
      flake-aspects.url = "github:vic/flake-aspects";
      flake-parts = {
        url = "github:hercules-ci/flake-parts";
        inputs.nixpkgs-lib.follows = "nixpkgs-lib";
      };

      # Config wrappers -- TODO
      nix-wrappers = {
        url = "github:BirdeeHub/nix-wrapper-modules";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };
  };

  imports = [
    inputs.flake-file.flakeModules.dendritic
    inputs.flake-file.flakeModules.nix-auto-follow
    inputs.flake-aspects.flakeModule
  ];
}
