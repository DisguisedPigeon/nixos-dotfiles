{ inputs, ... }:
{
  flake.aspects.pepper.nixos = {
    custom.network = {
      install_home_wifi = true;
      ip = "192.168.1.3/24";
      interface = "wlan0";
    };

    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocales = [ ];
    };

    imports = with inputs.self.modules.nixos; [
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
    ];
  };
}
