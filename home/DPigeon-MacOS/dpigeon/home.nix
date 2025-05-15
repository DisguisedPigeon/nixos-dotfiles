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

  session-chooser.enable = true;
  neovim-customization.enable = true;

  zsh-customization.hostname = "DPigeon-MacOS";
  xsession.windowManager.awesome.enable = true;
  programs.chromium.enable = true;
  obs.enable = true;
  wezterm-customization.enable = true;

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

  home = {
    username = "dpigeon";
    homeDirectory = "/home/dpigeon";
    stateVersion = "23.05";
    # Packages with no home-manager config
    packages = [
      inputs.zen-browser.packages."${system}".beta
      pkgs.typora
      pkgs.ladybird
      pkgs.thunderbird
      pkgs.discord-canary
      pkgs.gimp
      pkgs.transmission_4-gtk
      pkgs.vlc
      pkgs.youtube-music
      pkgs.spotube
      pkgs.libreoffice-fresh
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
