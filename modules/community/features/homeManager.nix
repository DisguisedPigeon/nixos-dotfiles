{ inputs, ... }:
{
  flake.modules.homeManager.home-manager.imports = [
    inputs.self.modules.homeManager.nix-settings
  ];
  flake.modules.homeManager.home-manager = {
    systemd.user.startServices = "sd-switch";
    programs.home-manager.enable = true;
  };
}
