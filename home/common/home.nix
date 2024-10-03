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
      outputs.overlays.nvim-nightly
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
    base16Scheme = {
      system = "base16";
      name = "duskfox";
      slug = "duskfox";
      author = "EdenEast";
      description = "a short description of the scheme";
      variant = "'light' or 'dark'";
      palette = {
        base00 = "232136";
        base01 = "2d2a45";
        base02 = "373354";
        base03 = "47407d";
        base04 = "6e6a86";
        base05 = "e0def4";
        base06 = "cdcbe0";
        base07 = "e2e0f7";
        base08 = "eb6f92";
        base09 = "ea9a97";
        base0A = "f6c177";
        base0B = "a3be8c";
        base0C = "9ccfd8";
        base0D = "569fba";
        base0E = "c4a7e7";
        base0F = "eb98c3";
      };
    };
    image = ./configs/wallpaper.jpeg;
    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Ice";
    cursor.size = 22;
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
  gtk.iconTheme.name = "Papirus-Dark";
  qt.enable = true;

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
