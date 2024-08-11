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

  home = {
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
      rofi
      maple-mono-NF
      tor-browser
      kdePackages.kdeconnect-kde
      spotify
      youtube-music
    ];
  };

  programs.git.enable = true;

  services.kdeconnect = {
    enable = true;
    package = pkgs.kdePackages.kdeconnect-kde;
  };

  services.caffeine.enable = true;

  systemd.user.startServices = "sd-switch";

  programs.home-manager.enable = true;

  home.stateVersion = "23.05";
}
