{ lib, ... }:
{
  imports = [
    ./dev.nix
    ./dualboot.nix
    ./general-settings.nix
    ./graphics.nix
    ./hardware-optimizations.nix
    ./stylix.nix
    ./term-utils.nix
  ];
  dev.enable = lib.mkDefault false;
  dualboot.enable = lib.mkDefault false;
  general.enable = lib.mkDefault true;
  graphics.enable = lib.mkDefault false;
  stylix.enable = lib.mkDefault false;
  term.enable = lib.mkDefault true;
}
