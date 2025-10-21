{ inputs, ... }:
{
  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];

  flake-file.inputs = {
    home-manager.url = "github:nix-community/home-manager";
  };
}
