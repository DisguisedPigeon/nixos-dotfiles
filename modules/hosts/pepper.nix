{ inputs, ... }:
{
  flake-file.inputs = {
    hardware.url = "github:nixos/nixos-hardware";
  };

  flake.modules.nixos.pepper = {
    programs.bash.enable = true;
    imports = with inputs.self.modules.nixos; [
      pepper-hardware
      inputs.hardware.nixosModules.raspberry-pi-4

      immutable-users

      # Users
      dpigeon
      remote-build

      # Services
      docker
      ssh-server
      tailscale

      # nix
      nix-settings
      sops

      # System
      hosts
      locale
      network-pepper
    ];
  };
}
