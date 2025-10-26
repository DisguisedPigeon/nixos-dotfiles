{ inputs, ... }:
let
  flake-file.inputs.hardware.url = "github:nixos/nixos-hardware";

  flake.modules.nixos.salt =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        # Apps
        obs
        docker
        git

        # DMs
        hyprland
        niri

        # Bundles
        ui

        # Users
        dpigeon

        # System
        locale
        salt-hardware
        inputs.hardware.nixosModules.asus-zephyrus-ga502
      ];

      users.users.dpigeon.extraGroups = [
        "wheel"
        "docker"
      ];

      environment.systemPackages = [ pkgs.ntfs3g ];
      boot.loader.limine.extraEntries = builtins.concatStringsSep "\n" [
        "/Windows"
        "\tprotocol: efi"
        "\tpath: boot():/EFI/microsoft/boot/bootmgfw.efi"
      ];
      dualboot.enable = true;

      fileSystems."/mnt/disk2" = {
        fsType = "ntfs";
        options = [
          "noatime"
          "defaults"
          "user"
          "rw"
        ];
        device = "/dev/disk/by-uuid/92F44E63F44E49A5";
      };

      services.fstrim.enable = true;

      system.stateVersion = "24.05";
    };
in
{
  inherit flake flake-file;
}
