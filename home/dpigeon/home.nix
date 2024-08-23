{ outputs, pkgs, ... }:
{
  imports = [
    ./zsh.nix
    ./nvim.nix
    ./kitty.nix
    ./hyprland.nix
    ./starship.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      # neovim-nightly-overlay.overlays.default
    ];
    config = {
      allowUnfree = true;
    };
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.tokyonight-gtk-theme;
      name = "TokyoNight";
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };
  xdg.enable = true;

  home = {
    pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.banana-cursor;
      name = "Banana cursor";
      size = 16;
    };
    username = "dpigeon";
    homeDirectory = "/home/dpigeon";
    packages = with pkgs; [
      steam
      floorp
      discord
      amule
      transmission_4-qt
      syncplay
      inkscape
      vlc
      maple-mono-NF
      tor-browser
      kdePackages.kdeconnect-kde
      spotify
      youtube-music
    ];
  };

  programs.git.enable = true;

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
