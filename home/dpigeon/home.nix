{ pkgs, ... }:
{
  imports = [
    ./zsh.nix
    ./starship.nix
    ../common
  ];

  home = {
    username = "dpigeon";
    homeDirectory = "/home/dpigeon";
    stateVersion = "23.05";
    # No home-manager config packages
    packages = with pkgs; [
      obs-studio
      discord
      gimp
      floorp
      amule
      transmission_4-gtk
      syncplay
      inkscape
      vlc
      kdePackages.kdeconnect-kde
      youtube-music
    ];
  };
}
