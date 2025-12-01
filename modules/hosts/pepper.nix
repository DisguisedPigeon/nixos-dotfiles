{ inputs, ... }:
let
  flake-file.inputs.hardware.url = "github:nixos/nixos-hardware";
  flake.modules.nixos.pepper =
    { pkgs, lib, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        inputs.hardware.nixosModules.raspberry-pi-4

        dpigeon
        locale
        ssh-server
        pepper-hardware
        sops
      ];

      services.openssh.settings.PermitRootLogin = "yes";
      users.mutableUsers = true;

      networking = {
        interfaces.wlan0 = {
          ipv4.addresses = [
            {
              address = "192.168.1.3";
              prefixLength = 24;
            }
          ];
        };
        wireless = {
          secretsFile = "/run/secrets/net-secretsFile";
          enable = true;
          networks."ext:ssid_home".psk = "ext:psk_home";
          interfaces = [ "wlan0" ];
        };
        useDHCP = false;
        defaultGateway = "192.168.1.1";
        nameservers = [
          "1.1.1.1"
          "1.0.0.1"
        ];
        hostName = "Pepper";
      };

      users.users.dpigeon.shell = lib.mkForce pkgs.bashInteractive;
    };
in
{
  inherit flake flake-file;
}
