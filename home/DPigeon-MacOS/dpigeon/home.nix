{ pkgs, outputs,... }:
{
  imports = [ ../../common ];

  home = {
    username = "dpigeon";
    homeDirectory = "/home/dpigeon";
    sessionVariables.EDITOR = "nvim";

    packages = [
      pkgs.tor-browser
      pkgs.typora
      pkgs.discord-canary
      pkgs.gimp3
      pkgs.transmission_4-gtk
      pkgs.vlc
      pkgs.syncplay
      pkgs.chromium
      pkgs.rpi-imager
      pkgs.youtube-music
      pkgs.libreoffice-fresh
      pkgs.gcr
    ];

    stateVersion = "23.05";
  };
  services.gnome-keyring.enable = true;
}
