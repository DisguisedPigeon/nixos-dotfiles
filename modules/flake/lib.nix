{
  inputs,
  self,
  lib,
  ...
}:
let
  linux = mkNixos "x86_64-linux";
  linux-arm = mkNixos "aarch64-linux";

  mkNixos =
    architecture: name:
    inputs.nixpkgs.lib.nixosSystem {
      system = architecture;
      modules = [
        self.modules.nixos.nixos
        self.modules.nixos.${name}
        {
          networking.hostName = lib.mkDefault name;
          nixpkgs.hostPlatform = lib.mkDefault architecture;
          system.stateVersion = lib.mkDefault "25.05";
        }
      ];
    };

  mkHome =
    name: hostname: stateVersion:
    let
      host = self.nixosConfigurations.${hostname};
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = host.pkgs;

      extraSpecialArgs.osConfig = host.config;

      modules = [
        self.modules.homeManager.home-manager
        self.modules.homeManager."${name}-${hostname}"
        {
          home.username = name;
          home.homeDirectory = "/home/${name}";
          home.stateVersion = stateVersion;
        }
      ];
    };
in
{
  flake.lib = {
    mk-home = { inherit mkHome; };
    mk-os = { inherit mkNixos linux linux-arm; };
  };
}
