{ inputs, ... }:
let
  flake.modules.nixos.salt.imports = with inputs.self.modules.nixos; [];
  flake.modules.nixos.salt = {};
in
{
  inherit flake;
}
