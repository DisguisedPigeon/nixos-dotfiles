{ inputs, ... }:
let
  flake.modules.nixos.pepper.imports = with inputs.self.modules.nixos; [
    limine
    pepper-hardware
  ];
in
{
  inherit flake;
}
