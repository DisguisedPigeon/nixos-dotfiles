{
  flake.aspects.boot.nixos = {
    boot = {
      loader.efi.canTouchEfiVariables = true;

      initrd.availableKernelModules = [
        "usb_storage"
        "sd_mod"
      ];
    };
  };
}
