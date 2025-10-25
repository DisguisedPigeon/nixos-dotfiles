{
  flake.modules.nixos.boot = {
    boot = {
      loader.efi.canTouchEfiVariables = true;

      binfmt.emulatedSystems = [ "aarch64-linux" ];

      boot.initrd.availableKernelModules = [
        "usb_storage"
        "sd_mod"
      ];
    };
  };
}
