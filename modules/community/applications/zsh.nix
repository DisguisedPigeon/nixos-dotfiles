{ ... }:
let
  flake.modules.nixos.zsh = { };
in
{
  inherit flake;
}
