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

  neovim-customization.enable = true;

  zsh-customization.hostname = "DPigeon-MacOS";
  programs.chromium.enable = true;
  alacritty-customization.enable = true;

  home = {
    username = "dpigeon";
    homeDirectory = "/home/dpigeon";
    stateVersion = "23.05";
    # Packages with no home-manager config
    packages = [
      inputs.zen-browser.packages."${system}".beta
      pkgs.typora
      pkgs.thunderbird
      pkgs.obs-studio
      pkgs.discord-canary
      pkgs.gimp
      pkgs.transmission_4-gtk
      pkgs.vlc
      pkgs.youtube-music
    ];

    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  hyprland-customization = {
    browser = {
      package = inputs.zen-browser.packages."${system}".beta;
      command = "zen";
    };
    terminal.command = "alacritty";
  };

  # User-specific config
  programs.zsh = {
    shellAliases = {
      nupdate = "sudo nixos-rebuild --flake .#${config.zsh-customization.hostname} switch";
      fupdate = "sudo nix flake update && sudo nixos-rebuild --flake .#${config.zsh-customization.hostname} switch && home-manager --flake .#${config.home.username}@${config.zsh-customization.hostname} switch";
    };
  };
}
