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
  ];
  default_home.enable = lib.mkDefault true;
  zsh-customization.enable = lib.mkDefault true;
  neovim-customization.enable = lib.mkDefault true;
  kitty-customization.enable = lib.mkDefault true;
  plasma-customization.enable = lib.mkDefault true;
  hyprland-customization.enable = lib.mkDefault true;
  starship-customization.enable = lib.mkDefault true;
}
