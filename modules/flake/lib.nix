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

          nixpkgs.overlays = [
            (_final: prev: {
              kernelPackagesExtensions = prev.kernelPackagesExtensions ++ [
                (_: kernelPrev: {
                  # TODO: Wait for patch to be merged upstream, then remove this overlay
                  # Workaround for v4l2loopback modules.alias conflict on kernel 6.18.57+
                  # Issue: https://github.com/NixOS/nixpkgs/issues/575851
                  # Pull: https://github.com/NixOS/nixpkgs/pull/575861
                  v4l2loopback = kernelPrev.v4l2loopback.overrideAttrs (oldAttrs: {
                    postInstall = (oldAttrs.postInstall or "") + ''
                      find "$out/lib/modules" -type f -name 'modules.*' -delete
                    '';
                  });
                })
              ];
            })
          ];

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
