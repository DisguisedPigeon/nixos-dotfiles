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
    interfaces.wlan0 = {
      ipv4.addresses = [
        {
          address = "192.168.1.3";
          prefixLength = 24;
        }
      ];
    };
    wireless = {
      enable = true;
      networks."NETWORK".psk = "SECRET";
      interfaces = [ "wlan0" ];
    };
    useDHCP = false;
    defaultGateway = "192.168.1.1";
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    hostName = "Pepper";
  };

  nix.settings.trusted-users = [ "@wheel" ];

  userlist = {
    dpigeon = false;
  };

  userConfigs = {
    shell = pkgs.zsh;
    initialPassword = "ligma";
    isNormalUser = true;
    extraGroups = [ "docker" ];
  };

  services.openssh.permitRootLogin = "yes";
  # --- Build-specific ---
  system.stateVersion = "25.11";
}
