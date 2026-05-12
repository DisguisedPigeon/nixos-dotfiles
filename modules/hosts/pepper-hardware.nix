{
  flake.modules.nixos.pepper-hardware =
    { lib, modulesPath, ... }:
    {
      imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "usbhid"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ ];
      boot.extraModulePackages = [ ];

      fileSystems."/" = {
        device = "/dev/disk/by-label/NIXOS_SD";
        fsType = "ext4";
      };
      # fileSystems."/nix" = { device = "/dev/disk/by-label/NIX_STORE"; fsType = "ext4"; };

      swapDevices = [ ];

      nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
    };
}
