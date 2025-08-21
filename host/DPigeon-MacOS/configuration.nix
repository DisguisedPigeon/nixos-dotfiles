{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    inputs.hardware.nixosModules.asus-zephyrus-ga502
    ./hardware-configuration.nix
    ../modules
  ];

  ui-bundle = true;

  environment.systemPackages = [
    pkgs.ntfs3g
    pkgs.banana-cursor
    pkgs.v4l-utils
  ];

  networking.hostName = "DPigeon-MacOS";

  boot = {
    initrd.availableKernelModules = [
      "usb_storage"
      "sd_mod"
    ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback.out ];
    kernelModules = [ "v4l2loopback" ];
    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
    '';
    loader.limine = {
      extraEntries = ''
        /Windows
              protocol: efi
              path: boot():/EFI/microsoft/boot/bootmgfw.efi
      '';
    };
  };

  adminConfigs = {
    shell = pkgs.zsh;
    initialPassword = "ligma";
    isNormalUser = true;
    extraGroups = [
      "dpigeon"
      "wheel"
      "user"
      "docker"
    ];
  };

  programs = {
    hyprlock.enable = true;
    hyprland.enable = true;
    niri.enable = true;
  };

  # --- Build-specific ---
  system.stateVersion = "24.05";
}
