{ inputs, ... }:
{
  flake.modules.homeManager.home-manager.imports = [
    inputs.home-manager.flakeModules.home-manager
    inputs.self.modules.homeManager.nix-settings
    inputs.self.modules.homeManager.unfree
  ];
}
