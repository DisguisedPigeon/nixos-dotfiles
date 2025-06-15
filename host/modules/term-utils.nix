{ pkgs, ... }:
{
  programs.zsh.enable = true;

  environment = {
    systemPackages = [
      pkgs.neovim
      pkgs.git
    ];

    variables = {
      editor = "nvim";
    };

    pathsToLink = [
      "/share/zsh"
      "/share/xdg-desktop-portal"
      "/share/applications"
    ];
  };
}
