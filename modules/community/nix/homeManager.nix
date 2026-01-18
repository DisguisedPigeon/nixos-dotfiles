{ inputs, ... }:
{
  flake.modules.homeManager.home-manager = {
    imports = [ inputs.self.modules.homeManager.nix-settings ];

    systemd.user.startServices = "sd-switch";
    programs.home-manager.enable = true;
  };
}
