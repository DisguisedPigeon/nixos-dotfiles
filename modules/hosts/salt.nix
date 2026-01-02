{ inputs, ... }:
let
  flake-file.inputs.hardware.url = "github:nixos/nixos-hardware";

  flake.modules.nixos.salt =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        # Apps
        kanata
        obs
        docker
        git
        dms

        # Secrets
        sops

        # DMs
        mango
        niri

        # Bundles
        ui

        # Users
        dpigeon

        # System
        bluetooth
        locale
        salt-hardware
        inputs.hardware.nixosModules.asus-zephyrus-ga502
      ];

      users.users.dpigeon.extraGroups = [
        "wheel"
        "docker"
      ];

      environment.systemPackages = [
        pkgs.ntfs3g
        pkgs.qemu
      ];

      boot.loader.limine.extraEntries = builtins.concatStringsSep "\n" [
        "/Windows"
        "\tprotocol: efi"
        "\tpath: boot():/efi/Microsoft/Boot/bootmgfw.efi"
      ];

      fileSystems."/disk2" = {
        fsType = "ntfs";
        options = [
          "noatime"
          "defaults"
          "user"
          "rw"
        ];
        device = "/dev/disk/by-label/SUGON";
      };

      services.fstrim.enable = true;

      system.stateVersion = "24.05";
    };
in
{
  inherit flake flake-file;
}
