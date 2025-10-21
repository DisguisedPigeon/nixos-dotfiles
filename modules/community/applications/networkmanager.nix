{ ... }:
let
  flake.modules.nixos.networkmanager = {
    networking.networkmanager.enable = true;
  };
in
{
  inherit flake;
}
