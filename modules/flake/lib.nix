{
  inputs,
  self,
  lib,
  ...
}:
let
  # Declares all needed options for a nixos system
  mkNixos = (
    arch: name: stateVersion:
    inputs.nixpkgs.lib.nixosSystem {
      system = arch;
      modules = [
        self.modules.nixos.nixos
        self.modules.nixos.${name}
        {
          networking.hostName = lib.mkDefault name;
          nixpkgs.hostPlatform = lib.mkDefault arch;
          system = { inherit stateVersion; };
        }
      ];
    }
  );

  # Declares all needed options for a home manager config
  mkHome = (
    username: hostname: stateVersion:

    let
      host = self.nixosConfigurations.${hostname};
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = host.pkgs;

      extraSpecialArgs.osConfig = host.config;

      modules = [
        self.modules.homeManager.home-manager
        self.modules.homeManager."${username}-${hostname}"
        {
          home = {
            inherit stateVersion username;
            homeDirectory = "/home/${username}";
          };
        }

      ];
    }
  );
in
{
  flake.lib = {
    inherit mkNixos mkHome;
    mkLinux = mkNixos "x86_64-linux";
    mkLinuxArm = mkNixos "aarch64-linux";
  };
}
