{ inputs, ... }:
{
  flake.aspects.pepper.nixos = {
    custom.network.ip = "192.168.1.3/24";
    custom.network.net-interface = "wlan0";

    sops.secrets = {
      user-password.neededForUsers = true;
      github-PAT = { };
      home-pass = { };
      home-ssid = { };
      pepper-nextcloud = { };
      pepper-dpigeon-nextcloud = { };
    };

    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocales = [ ];
    };

    imports = [
      ./hardware
    ]
    ++ (with inputs.self.modules.nixos; [
      # Userland
      nvim

      # Users
      dpigeon
      remotebuild

      # Services
      docker
      ssh-server
      tailscale
      nextcloud
      tmux
      forgejo
      git-server

      # nix
      nix-settings
      sops

      # System
      hosts
      locale
      nm
      pepper-hardware
    ]);
  };
}
