{ pkgs, ... }:
{
  imports = [
    ./zsh.nix
    ./starship.nix
    ../common/home.nix
  ];

  home = {
    username = "dpigeon";
    homeDirectory = "/home/dpigeon";
    packages = with pkgs; [
      obs-studio
      vesktop
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
