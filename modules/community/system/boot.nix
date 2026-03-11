{
  flake.aspects.boot.nixos =
    { lib, ... }:
    {
      boot = {
        loader.efi.canTouchEfiVariables = lib.mkDefault true;

        initrd.availableKernelModules = lib.mkDefault [
          "usb_storage"
          "sd_mod"
        ];
      };
    };
}
