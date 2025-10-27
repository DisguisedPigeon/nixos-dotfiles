{ pkgs, ... }:
{
  imports = [ ../common ];

  programs.zen-browser = {
    enable = true;
    profiles.default = {
      containersForce = true;
      containers = {
        Personal = {
          color = "purple";
          icon = "fingerprint";
          id = 1;
        };
        Work = {
          color = "blue";
          icon = "briefcase";
          id = 2;
        };
        Shopping = {
          color = "green";
          icon = "dollar";
          id = 3;
        };
      };
    };
    profiles.music = {
      id = 2;
    };
  };

  home = {
    username = "dpigeon";
    homeDirectory = "/home/dpigeon";
    sessionVariables.EDITOR = "nvim";

    packages = [
      pkgs.tor-browser
      pkgs.figma-linux
      pkgs.typora
      pkgs.discord-canary
      pkgs.gimp3
      pkgs.transmission_4-gtk
      pkgs.vlc
      pkgs.syncplay
      pkgs.whatsapp-for-linux
      pkgs.chromium
      pkgs.obsidian
      pkgs.youtube-music
      pkgs.libreoffice-fresh
      pkgs.gcr
    ];

    stateVersion = "23.05";
  };
  services.gnome-keyring.enable = true;
}
