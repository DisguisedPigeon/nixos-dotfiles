# Authored by vic AFAIK
{ inputs, lib, ... }:
let
  flake.lib.mk-os = {
    inherit mkNixos linux linux-arm;
  };

  linux = mkNixos "x86_64-linux" "nixos";
  linux-arm = mkNixos "aarch64-linux" "nixos";

  mkNixos =
    system: cls: name:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        inputs.self.modules.nixos.${cls}
        inputs.self.modules.nixos.${name}
        {
          networking.hostName = lib.mkDefault name;
          nixpkgs.hostPlatform = lib.mkDefault system;
          system.stateVersion = lib.mkDefault "25.05";
        }
      ];
    };
in
{
  inherit flake;
}
