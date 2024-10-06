# General configurations I don't expect to change
{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./nix-setup.nix
  ];

  options = {
    general.enable = lib.mkEnableOption "sets general configs I don't expect to change";
  };

  config =
    let
      opts = config.general;
    in
    lib.mkIf opts.enable {
      networking = {
        hostName = "DPigeon-MacOS";
        networkmanager.enable = true;
      };
      time.timeZone = "Europe/Madrid";
      i18n.defaultLocale = "gl_ES.UTF-8";
      environment = {
        systemPackages = [
          pkgs.home-manager
        ];
      };
      users.groups.configEditor.gid = 69420;
      users.users = {
        dpigeon = {
          shell = pkgs.zsh;
          initialPassword = "ligma";
          isNormalUser = true;
          extraGroups = [
            "wheel"
            "configEditor"
            "docker"
          ];
        };
      };
    };
}
