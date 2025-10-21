{ inputs, ... }:
let
  flake.modules.nixos.salt.imports = with inputs.self.modules.nixos; [
    salt-hardware
    ui
  ];
in
{
  inherit flake;
}
