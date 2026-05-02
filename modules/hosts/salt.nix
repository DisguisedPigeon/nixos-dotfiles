{ inputs, ... }:
{
  flake-file.inputs = {
    hardware.url = "github:nixos/nixos-hardware";
  };

  flake.modules.nixos.salt =
    { pkgs, ... }:
    {
      sops.secrets = {
        user-password = {
          neededForUsers = true;
        };
        github-PAT = { };
        home-pass = { };
        home-ssid = { };
      };

      environment.systemPackages = [
        pkgs.ntfs3g
        pkgs.qemu
        pkgs.xdg-desktop-portal-gtk
        pkgs.home-manager
        pkgs.noto-fonts
      ];

      boot = {
        binfmt.emulatedSystems = [ "aarch64-linux" ];

        loader.limine.extraEntries = builtins.concatStringsSep "\n" [
          "/Windows"
          "\tprotocol: efi"
          "\tpath: boot():/efi/Microsoft/Boot/bootmgfw.efi"
        ];
      };

      fileSystems."/disk2" = {
        fsType = "ntfs";
        options = [
          "noatime"
          "defaults"
          "user"
          "rw"
        ];
        device = "/dev/disk/by-label/SUGON";
      };

      services.fstrim.enable = true;

      services = {
        libinput.enable = true;
        flatpak.enable = true;
      };

      imports = with inputs.self.modules.nixos; [
        salt-hardware
        inputs.hardware.nixosModules.asus-zephyrus-ga502

        # Users
        dpigeon

        # Apps
        # obs
        sddm
        noctalia

        # Nix
        nix-settings
        sops
        stylix

        # Services
        bluetooth
        kanata
        tailscale
        docker
        logind
        power-profiles
        #dunst

        # System
        boot
        hosts
        limine
        locale
        network-salt
        shell

        # Term
        git
        zsh
        nvim
        tmux

        # Compositors / Window Managers
        mango

        # Theming
        xdg
      ];

    };
}
