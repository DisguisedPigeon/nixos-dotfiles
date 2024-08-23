{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./zsh.nix
    ./nvim.nix
    ./kitty.nix
    ./hyprland.nix
    ./starship.nix
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";
    image = ./configs/wallpaper.png;
    cursor.package = pkgs.rose-pine-cursor;
    cursor.name = "BreezeX-RoséPine";
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
      applications = 1.0;
      terminal = 0.8;
      desktop = 1.0;
      popups = 1.0;
    };
    polarity = "dark";
  };

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

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };
  };
  xdg.enable = true;

  home = {
    username = "test";
    homeDirectory = "/home/test";
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
