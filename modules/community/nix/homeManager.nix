{ inputs, ... }:
{
  flake.modules.homeManager.home-manager =
    { lib, ... }:
    {
      imports = [ inputs.self.modules.homeManager.nix-settings ];

      systemd.user.startServices = lib.mkDefault "sd-switch";
      programs.home-manager.enable = lib.mkDefault true;
    };
}
