{ inputs, ... }:
let
  flake.modules.nixos.salt.imports = with inputs.self.modules.nixos; [
    limine
  ];
  flake.modules.nixos.salt = { };
in
{
  inherit flake;
}
