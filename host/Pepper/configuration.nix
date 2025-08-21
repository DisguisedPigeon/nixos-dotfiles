{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.hardware.nixosModules.raspberry-pi-4
    ./hardware-configuration.nix
    ../modules
  ];

  server-bundle = true;

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;

    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };
  fileSystems."/".options = [ "noatime" ];

  networking = {
    hostName = "Pepper";
    wireless = {
      enable = true;
      networks."ssid".psk = "super-secret-password";
      interfaces = [ "wlan0" ];
    };
  };

  userlist = {
    dpigeon = false;
  };

  userConfigs = {
    shell = pkgs.zsh;
    initialPassword = "ligma";
    isNormalUser = true;
    extraGroups = [ "docker" ];
  };

  # --- Build-specific ---
  system.stateVersion = "25.11";
}
