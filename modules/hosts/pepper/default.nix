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

    boot.loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };

    imports = with inputs.self.modules.nixos; [
      # Userland
      nvim

      # Users
      dpigeon
      dpigeon-pepper
      remotebuild

      # Services
      docker
      ssh-server
      tailscale
      nextcloud
      tmux
      git-server

      # nix
      nix-settings
      pepper-sops
      sops

      # System
      locale
      nm
      pepper-hardware
    ];
  };
}
