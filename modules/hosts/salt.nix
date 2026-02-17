{ inputs, ... }:
let
  flake-file.inputs.hardware.url = "github:nixos/nixos-hardware";

  flake.modules.nixos.salt =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        # Apps
        kanata
        obs
        docker
        git
        sddm
        zsh
        limine
        stylix
        shell
        tailscale
        emacs

        # Secrets
        sops

        # DMs
        mango
        niri

        # Users
        dpigeon

        # System
        bluetooth
        locale
        network-salt
        salt-hardware
        inputs.hardware.nixosModules.asus-zephyrus-ga502
      ];

      users.users.dpigeon.extraGroups = [
        "wheel"
        "docker"
      ];

      environment.systemPackages = [
        pkgs.ntfs3g
        pkgs.qemu
        pkgs.xdg-desktop-portal-gtk
        pkgs.home-manager
        pkgs.noto-fonts
      ];

      boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

      boot.loader.limine.extraEntries = builtins.concatStringsSep "\n" [
        "/Windows"
        "\tprotocol: efi"
        "\tpath: boot():/efi/Microsoft/Boot/bootmgfw.efi"
      ];

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

      xdg.portal = {
        enable = true;
        config = {
          common = {
            default = [ "gtk" ];
          };
          niri = {
            default = [
              "gnome"
              "gtk"
            ];
          };
          hyprland = {
            default = [
              "hyprland"
              "gtk"
            ];
          };
        };
        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
        ];
      };

      services = {
        libinput.enable = true;
        flatpak.enable = true;
      };
    };
in
{
  inherit flake flake-file;
}
