{ inputs, ... }:
let
  flake-file.inputs.hardware.url = "github:nixos/nixos-hardware";
  flake.modules.nixos.pepper =
    {
      pkgs,
      lib,
      ...
    }:
    {
      imports = with inputs.self.modules.nixos; [
        # Apps
        docker
        ssh-server

        # Secrets
        sops

        # Users
        dpigeon

        # System
        network
        locale
        pepper-hardware
        inputs.hardware.nixosModules.raspberry-pi-4
      ];

      nixpkgs.buildPlatform.system = "x86_64-linux";

      services.openssh.settings.PermitRootLogin = "yes";
      users.mutableUsers = true;

      networking.interfaces.wlan0.ipv4.addresses = [
        {
          address = "192.168.1.3";
          prefixLength = 24;
        }
      ];

      users.users.dpigeon.shell = lib.mkForce pkgs.bashInteractive;
    };
in
{
  inherit flake flake-file;
}
