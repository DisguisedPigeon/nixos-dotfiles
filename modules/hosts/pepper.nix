{ inputs, ... }:
let
  flake.modules.nixos.pepper = {
    imports = with inputs.self.modules.nixos; [
      limine
      pepper-hardware

      (import ./_users.nix {
        dpigeon = {
          initialPassword = "ligma";
          isNormalUser = true;
          extraGroups = [
            "dpigeon"
            "user"
          ];
        };
      })
    ];
  };
in
{
  inherit flake;
}
