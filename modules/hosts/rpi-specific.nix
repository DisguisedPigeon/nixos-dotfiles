{
  flake.modules.nixos.rpi-specific =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    {
      hardware.firmware = [ (pkgs.callPackage ../../packages/raspberry-pi-wireless-firmware.nix { }) ];
      assertions = [
        {
          assertion = (lib.versionAtLeast config.boot.kernelPackages.kernel.version "6.1");
          message = "This version of raspberry pi 4 dts overlays requires a newer kernel version (>=6.1). Please upgrade nixpkgs for this system.";
        }
      ];
      hardware.deviceTree.filter = lib.mkDefault "bcm2711-rpi-*.dtb";
      boot = {
        loader = {
          grub.enable = lib.mkDefault false;
          generic-extlinux-compatible.enable = lib.mkDefault true;
        };
        initrd.systemd.tpm2.enable = false;
        initrd.availableKernelModules = [
          "pcie-brcmstb" # required for the pcie bus to work
          "reset-raspberrypi" # required for vl805 firmware to load
          "usb-storage"
          "usbhid"
          "vc4"
        ];
      };
      users.groups.gpio = lib.mkDefault { };

      # the bit that matters to lgpio here is
      # "${pkgs.coreutils}/bin/chgrp gpio /dev/%k && chmod 660 /dev/%k"
      # see https://github.com/NixOS/nixpkgs/pull/352308

      # sudo udevadm test --action=add /dev/gpiochip0 to test

      # import lgpio; lgpio.gpiochip_open(0) should show "1" and not raise
      # an exception

      services.udev.extraRules = lib.mkBefore ''
        KERNEL=="gpiomem", GROUP="gpio", MODE="0660"
        SUBSYSTEM=="gpio", KERNEL=="gpiochip*", ACTION=="add", PROGRAM="${pkgs.bash}/bin/bash -c '${pkgs.coreutils}/bin/chgrp gpio /dev/%k && chmod 660 /dev/%k && ${pkgs.coreutils}/bin/chgrp -R gpio /sys/class/gpio && ${pkgs.coreutils}/bin/chmod -R g=u /sys/class/gpio'"
        SUBSYSTEM=="gpio", ACTION=="add", PROGRAM="${pkgs.bash}/bin/bash -c '${pkgs.coreutils}/bin/chgrp -R gpio /sys%p && ${pkgs.coreutils}/bin/chmod -R g=u /sys%p'"
      '';

      boot.kernelParams = [
        "iomem=relaxed" # for pigpiod
      ];
    };
}
