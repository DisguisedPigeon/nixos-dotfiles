{ pkgs, ... }:
{
  services.flatpak.enable = true;

  networking = {
    hostName = "DPigeon-MacOS";
    networkmanager.enable = true;
  };
  time.timeZone = "Europe/Madrid";
  i18n = {
    defaultLocale = "gl_ES.UTF-8";
    extraLocales = [
      "es_ES.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];
  };
  environment.systemPackages = [ pkgs.home-manager ];

  users.users.dpigeon = {
    shell = pkgs.zsh;
    initialPassword = "ligma";
    isNormalUser = true;
    extraGroups = [
      "dpigeon"
      "wheel"
      "user"
    ];
  };
}
