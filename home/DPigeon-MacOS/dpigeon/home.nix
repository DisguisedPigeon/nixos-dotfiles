{ pkgs, config, ... }:
{
  imports = [
    ../../common
  ];

  zsh-customization.hostname = "DPigeon-MacOS";
  programs.chromium.enable = true;

  home = {
    username = "dpigeon";
    homeDirectory = "/home/dpigeon";
    stateVersion = "23.05";
    # Packages with no home-manager config 
    packages = with pkgs; [
      typora
      obs-studio
      discord
      gimp
      floorp
      amule
      transmission_4-gtk
      syncplay
      inkscape
      vlc
      kdePackages.kdeconnect-kde
      youtube-music
    ];

    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  # User-specific config
  programs.zsh = {
    shellAliases = {
      nupdate = "sudo nixos-rebuild --flake .#${config.zsh-customization.hostname} switch";
      fupdate = "sudo nix flake update . && sudo nixos-rebuild --flake .#${config.zsh-customization.hostname} switch && home-manager --flake .#${config.home.username}@${config.zsh-customization.hostname} switch";
    };
  };
}
