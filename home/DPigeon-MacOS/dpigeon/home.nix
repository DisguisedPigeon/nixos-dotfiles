{
  pkgs,
  config,
  inputs,
  system,
  ...
}:
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
    packages = [
      inputs.zen-browser.packages."${system}".specific
      pkgs.typora
      pkgs.thunderbird
      pkgs.obs-studio
      pkgs.discord
      pkgs.gimp
      pkgs.floorp
      pkgs.amule
      pkgs.transmission_4-gtk
      pkgs.syncplay
      pkgs.inkscape
      pkgs.vlc
      pkgs.kdePackages.kdeconnect-kde
      pkgs.youtube-music
    ];

    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  # User-specific config
  programs.zsh = {
    shellAliases = {
      nupdate = "sudo nixos-rebuild --flake .#${config.zsh-customization.hostname} switch";
      fupdate = "sudo nix flake update && sudo nixos-rebuild --flake .#${config.zsh-customization.hostname} switch && home-manager --flake .#${config.home.username}@${config.zsh-customization.hostname} switch";
    };
  };
}
