{ inputs, ... }:
let
  flake.modules.nixos.pepper = {
    imports = with inputs.self.modules.nixos; [
      locale
      limine
      pepper-hardware
      dpigeon
    ];
  };
in
{
  inherit flake;
}
