{
  flake.aspects.salt-hardware.nixos =
    {
      config,
      lib,
      modulesPath,
      ...
    }:
    {
      imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

      boot = {
        kernelModules = [ "kvm-amd" ];
        extraModulePackages = [ ];

        initrd = {
          kernelModules = [ ];

          availableKernelModules = [
            "xhci_pci"
            "nvme"
            "usbhid"
            "usb_storage"
            "sd_mod"
          ];
        };
      };

      fileSystems = {
        "/" = {
          device = "/dev/disk/by-label/ROOT";
          fsType = "btrfs";

          options = [
            "subvol=root"
            "compress=zstd"
          ];
        };

        "/nix" = {
          device = "/dev/disk/by-label/ROOT";
          fsType = "btrfs";

          options = [
            "subvol=nix"
            "compress=zstd"
            "noatime"
          ];
        };

        "/boot" = {
          device = "/dev/disk/by-label/BOOT";
          fsType = "vfat";

          options = [
            "fmask=0022"
            "dmask=0022"
          ];
        };

        "/swap" = {
          device = "/dev/disk/by-label/ROOT";
          fsType = "btrfs";

          options = [
            "subvol=swap"
            "noatime"
          ];
        };

        "/disk2" = {
          fsType = "ntfs";
          device = "/dev/disk/by-label/SUGON";

          options = [
            "noatime"
            "defaults"
            "user"
            "rw"
          ];
        };
      };

      swapDevices = [
        {
          device = "/swap/swapfile";
          size = 12 * 1024;
        }
      ];

      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
