{ outputs, pkgs, ... }:
{
  imports = [
    ./zsh.nix
    ./starship.nix
    ../common/home.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
    ];
    config = {
      allowUnfree = true;
    };
  };

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
