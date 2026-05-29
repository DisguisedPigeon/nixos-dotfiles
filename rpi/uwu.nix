{ pkgs, lib, ... }:
{
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
  environment.systemPackages = [
    pkgs.vim
    pkgs.git
  ];
  services.openssh.enable = true;
  networking.hostName = "pepper";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [ ];
  };
  users.users = {
    dpigeon = {
      password = "default";
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
    git.password = "default";
  };

  networking = {
    interfaces."wlan0".useDHCP = true;
    wireless = {
      interfaces = [ "wlan0" ];
      enable = true;
      networks = {
        networkSSID.psk = "password";
      };
    };
  };

  nix.settings = {
    experimental-features = lib.mkDefault "nix-command flakes";
    trusted-users = [
      "root"
      "@wheel"
    ];
  };
}
