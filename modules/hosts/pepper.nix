{ inputs, ... }:
{
  flake.modules.nixos.pepper = {
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
      git

      # nix
      nix-settings
      sops

      # System
      hosts
      locale
      network-pepper
      pepper-hardware
    ];
  };
}
