{
  flake.modules.nixos.pepper-hardware =
    { modulesPath, ... }:
    {
      imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

      boot = {
        extraModulePackages = [ ];

        initrd = {
          availableKernelModules = [ "xhci_pci" ];
          kernelModules = [ ];
        };
      };

      fileSystems."/" = {
        device = "/dev/disk/by-label/NIXOS_SD";
        fsType = "ext4";
      };

      fileSystems."/mnt" = {
        device = "/dev/disk/by-label/EXTERNAL_DATA";
        fsType = "ext4";
      };

      fileSystems."/nix" = {
        device = "/dev/disk/by-label/NIX_STORE";
        fsType = "ext4";
      };

      swapDevices = [ ];
    };
}
