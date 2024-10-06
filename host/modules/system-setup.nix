{ lib, ... }:
{
  imports = [
    ./dev.nix
    ./dualboot.nix
    ./general-settings.nix
    ./graphics.nix
    ./laptop.nix
    ./stylix.nix
    ./term-utils.nix
    ./test-user.nix
  ];
  dev.enable = lib.mkDefault false;
  dualboot.enable = lib.mkDefault false;
  general.enable = lib.mkDefault true;
  graphics.enable = lib.mkDefault false;
  laptop.enable = lib.mkDefault false;
  stylix.enable = lib.mkDefault false;
  term.enable = lib.mkDefault true;
  test-user.enable = lib.mkDefault false;
}
