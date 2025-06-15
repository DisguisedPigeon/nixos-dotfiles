{ pkgs, ... }:
{
  xdg.configFile.wezterm = {
    enable = true;
    source = ./configs/wezterm;
    recursive = true;
  };
  home.packages = [
    pkgs.wezterm
    (pkgs.writeShellScriptBin "session-chooser" ''
      #!/usr/bin/env bash

      if [ -z $WEZTERM_PANE ]; then
        exit 1
      fi

      if ! [ -d ~/Personal ]; then
        mkdir ~/Personal
      fi

      if ! [ -d ~/Uni ]; then
        mkdir ~/Uni
      fi

      if [ -v git ] && ! [ -d /home/.nixos-config ]; then
        git clone --depth=1 --single-branch https://github.com/DisguisedPigeon/nixos-dotfiles .nixos-config
      fi

      if chosen=$((find ~/Personal ~/Uni -mindepth 1 -maxdepth 1 -type d; echo /home/.nixos-config) | fzf); then
        wezterm start --cwd="$chosen" && wezterm cli kill-pane
      else
        echo "No value chosen"
      fi
    '')
  ];
}
