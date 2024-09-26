{ outputs, pkgs, ... }:
{
  imports = [
    ./nvim.nix
    ./zsh.nix
    ./kitty.nix
    ./hyprland.nix
    ./plasma.nix
    ./terminal.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
    ];
    config = {
      allowUnfree = true;
    };
  };
  programs.thunderbird = {
    enable = true;
    profiles.dpigeon = {
      isDefault = true;
    };
  };

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyodark-terminal.yaml";
    image = ./configs/wallpaper.png;
    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Ice";
    cursor.size = 32;
    fonts = {
      monospace = {
        package = pkgs.maple-mono-NF;
        name = "Maple Mono NF";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
    };
    opacity = {
      terminal = 0.8;
    };
    polarity = "dark";
  };

  gtk.enable = true;
  gtk.iconTheme.package = pkgs.papirus-icon-theme;
  gtk.iconTheme.name = "Papirus";

  xdg = {
    enable = true;
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      configPackages = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
      config = {
        common = {
          default = [ "gtk" ];
        };
        hyprland = {
          default = [
            "hyprland"
            "gtk"
          ];
        };
      };
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };

  programs.qutebrowser.enable = true;

  programs.chromium = {
    enable = true;
    extensions = [
      "epcnnfbjfcgphgdmggkamkmgojdagdnn" # ublock
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # dark reader
      "cfemcmeknmapecneeeaajnbhhgfgkfhp" # darkpdf
      "enpfonmmpgoinjpglildebkaphbhndek" # Tokyonight-ish
    ];
  };

  programs.git = {
    enable = true;
    extraConfig = {
      safe.directory = "/home/.nixos-config/.git";
    };
  };

  programs.yazi.enable = true;

  services.kdeconnect = {
    enable = true;
    package = pkgs.kdePackages.kdeconnect-kde;
  };

  services.caffeine.enable = true;

  systemd.user.startServices = "sd-switch";

  programs.home-manager.enable = true;

  home.stateVersion = "23.05";
}
