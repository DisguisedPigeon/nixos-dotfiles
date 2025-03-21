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
  wezterm-customization.enable = true;

  stylix.base16Scheme = {
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
