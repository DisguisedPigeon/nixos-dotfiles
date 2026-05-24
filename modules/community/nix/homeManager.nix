{ inputs, ... }:
{
  flake.aspects.home-manager = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.home-manager ];
      };

    homeManager =
      { lib, ... }:
      {
        imports = [ inputs.self.modules.homeManager.nix-settings ];

        systemd.user.startServices = lib.mkDefault "sd-switch";
        programs.home-manager.enable = lib.mkDefault true;
      };
  };
}
