{ inputs, ... }:
{
  flake.modules.nixos.pepper =
    { pkgs, lib, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        # Apps
        docker
        ssh-server
        tailscale

        # Secrets
        sops

        # Users
        dpigeon

        # System
        locale
        network-pepper
        pepper-hardware
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
}
