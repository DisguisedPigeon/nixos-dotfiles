{
  flake.aspects.pepper-hardware.nixos =
    { modulesPath, ... }:
    {
      imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

      boot = {
        kernelModules = [ ];
        extraModulePackages = [ ];

        initrd = {
          kernelModules = [ ];
          availableKernelModules = [
            "xhci_pci"
            "usbhid"
          ];
        };
      };

      fileSystems."/" = {
        device = "/dev/disk/by-label/NIXOS_SD";
        fsType = "ext4";
      };
      # fileSystems."/nix" = { device = "/dev/disk/by-label/NIX_STORE"; fsType = "ext4"; };

      swapDevices = [ ];
    };
}
