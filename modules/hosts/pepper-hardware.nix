# Based on the auto-generated hardware-configuration.nix
{ inputs, ... }:
{
  flake-file.inputs.hardware.url = "github:nixos/nixos-hardware";

  flake.modules.nixos.pepper-hardware =
    { modulesPath, ... }:
    {
      imports = [
        inputs.hardware.nixosModules.raspberry-pi-4
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

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

      swapDevices = [ ];
    };
}
