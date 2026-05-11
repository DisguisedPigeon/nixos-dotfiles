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

    boot.zfs.forceImportRoot = false;

    imports = with inputs.self.modules.nixos; [
      pepper-hardware
      rpi-specific
      # inputs.hardware.nixosModules.raspberry-pi-4

      # Users
      dpigeon
      remote-build

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
    ];
  };
}
