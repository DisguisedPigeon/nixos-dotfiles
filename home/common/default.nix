{ lib, ... }:
{
  imports = [
    ./home.nix
    ./git.nix
    ./zsh.nix
    ./nvim.nix
    ./llm.nix
    ./kitty.nix
    ./plasma.nix
    ./hyprland.nix
    ./starship.nix
    ./ghostty.nix
    ./yazi.nix
    ./alacritty.nix
    ./wezterm.nix
    ./obs.nix
  ];
  session-chooser.enable = lib.mkDefault false;
  default_home.enable = lib.mkDefault true;
  obs.enable = lib.mkDefault false;
  zsh-customization.enable = lib.mkDefault true;
  ghostty-customization.enable = lib.mkDefault false;
  wezterm-customization.enable = lib.mkDefault false;
  alacritty-customization.enable = lib.mkDefault false;
  neovim-customization.enable = lib.mkDefault true;
  neovim-customization.latex = lib.mkDefault true;
  kitty-customization.enable = lib.mkDefault false;
  git-customization.enable = lib.mkDefault true;
  plasma-customization.enable = lib.mkDefault true;
  hyprland-customization.enable = lib.mkDefault true;
  starship-customization.enable = lib.mkDefault true;
  yazi-customization.enable = lib.mkDefault true;
  llm.enable = lib.mkDefault false;
  nixpkgs.config = {
    allowUnfree = true;
  };
}
