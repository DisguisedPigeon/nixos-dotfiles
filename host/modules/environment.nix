{
  config,
  pkgs,
  lib,
  ...
}:
{

  environment = {
    systemPackages = lib.mkMerge [
      [
        pkgs.git
        pkgs.neovim
      ]
      (lib.mkIf config.ui-bundle [ pkgs.home-manager ])
    ];

    variables.editor = "nvim";

    pathsToLink = [
      "/share/zsh"
      "/share/xdg-desktop-portal"
      "/share/applications"
    ];
  };
}
