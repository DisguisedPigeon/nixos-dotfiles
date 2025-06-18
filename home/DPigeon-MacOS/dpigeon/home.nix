{ pkgs, ... }:
{
  imports = [ ../../common ];

  home = {
    username = "dpigeon";
    homeDirectory = "/home/dpigeon";
    sessionVariables.EDITOR = "nvim";

    packages = [
      pkgs.typora
      pkgs.discord-canary
      pkgs.gimp3
      pkgs.transmission_4-gtk
      pkgs.vlc
      pkgs.youtube-music
      pkgs.libreoffice-fresh
    ];

    stateVersion = "23.05";
  };
}
