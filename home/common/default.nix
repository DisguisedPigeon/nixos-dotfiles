{ lib, ... }:
{
  imports = [
    ./home.nix
    ./zsh.nix
    ./nvim.nix
    ./kitty.nix
    ./plasma.nix
    ./hyprland.nix
    ./starship.nix
    ./ghostty.nix
    ./yazi.nix
    ./alacritty.nix
  ];
  default_home.enable = lib.mkDefault true;
  zsh-customization.enable = lib.mkDefault true;
  ghostty-customization.enable = lib.mkDefault false;
  alacritty-customization.enable = lib.mkDefault false;
  neovim-customization.enable = lib.mkDefault true;
  kitty-customization.enable = lib.mkDefault false;
  plasma-customization.enable = lib.mkDefault true;
  hyprland-customization.enable = lib.mkDefault true;
  starship-customization.enable = lib.mkDefault true;
  yazi-customization.enable = lib.mkDefault true;
  nixpkgs.config = {
    allowUnfree = true;
  };
}
