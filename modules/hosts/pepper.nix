{ inputs, ... }:
let
  flake.modules.nixos.pepper.imports = with inputs.self.modules.nixos; [];
  flake.modules.nixos.pepper = {};
in
{
  inherit flake;
}
