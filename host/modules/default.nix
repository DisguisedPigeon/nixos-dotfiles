{ lib, pkgs, ... }:
{
  imports = [
    ./boot.nix
    ./display-managers.nix
    ./enabled-services.nix
    ./environment.nix
    ./locales.nix
    ./nix.nix
    ./sddm.nix
    ./stylix.nix
    ./users.nix
  ];

  config = {
    userlist = lib.mkDefault {
      dpigeon = true;
    };

    adminConfigs = lib.mkDefault {
      shell = pkgs.zsh;
      isNormalUser = true;
      extraGroups = [ "docker" ];
    };

    stylix.enable = lib.mkDefault true;

    general-bundle = lib.mkDefault true;
    ui-bundle = lib.mkDefault false;
    server-bundle = lib.mkDefault false;

    default-localization = lib.mkDefault true;
  };
}
