{ inputs, ... }:
{
  flake-file.inputs = {
    hardware.url = "github:nixos/nixos-hardware";
  };

  flake.modules.nixos.pepper = {
    sops.secrets = {
      user-password.neededForUsers = true;
      github-PAT = { };
      home-pass = { };
      home-ssid = { };
      pepper-nextcloud = { };
      pepper-dpigeon-nextcloud = { };
    };

    imports = with inputs.self.modules.nixos; [
      pepper-hardware
      inputs.hardware.nixosModules.raspberry-pi-4

      # Users
      dpigeon
      remote-build

      # Services
      docker
      ssh-server
      tailscale
      nextcloud
      tmux
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
