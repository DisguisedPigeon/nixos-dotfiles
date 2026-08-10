{ inputs, ... }:
{
  flake-file.inputs = {
    hardware.url = "github:nixos/nixos-hardware";
  };

  flake.aspects.salt.nixos = {
    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

    custom.network = {
      install_home_wifi = true;
      ip = "192.168.1.4/24";
      interface = "wlp3s0";
    };

    imports =
      # Dendritic modules
      (with inputs.self.modules.nixos; [
        # Host-specific
        salt-hardware
        salt-dualboot
        salt-extra-packages
        salt-sops

        # System
        boot
        limine
        locale
        shell
        nm

        # Users
        dpigeon

        # Services
        docker
        bluetooth
        tailscale
        logind
        kanata
        flatpak
        power-profiles
        ssh-client

        # Term
        git
        zsh
        nvim
        tmux

        # Apps
        mangowm
        noctalia
        sddm
        llama-cpp
        obs

        # Theming
        xdg

        # Nix-stuff
        sops
        nix-settings
        home-manager
        ui-theming
      ])
      ++ [ inputs.hardware.nixosModules.asus-zephyrus-ga502 ];

  };
}
