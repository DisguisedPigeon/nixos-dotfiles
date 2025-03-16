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

  llm.enable = true;
  neovim-customization.enable = true;

  zsh-customization.hostname = "DPigeon-MacOS";
  programs.chromium.enable = true;
  wezterm-customization.enable = true;

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
      pkgs.spotube
      pkgs.postman
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
    terminal.command = "wezterm";
  };

  # User-specific config
  programs.zsh = {
    shellAliases = {
      nupdate = "sudo nixos-rebuild --flake .#${config.zsh-customization.hostname} switch";
      fupdate = "sudo nix flake update && sudo nixos-rebuild --flake .#${config.zsh-customization.hostname} switch && home-manager --flake .#${config.home.username}@${config.zsh-customization.hostname} switch";
    };
  };
}
