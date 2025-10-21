{ inputs, ... }:
let
  flake.modules.nixos.salt =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        ui
        salt-hardware
        (import ./_users.nix {
          dpigeon = {
            shell = pkgs.zsh;
            initialPassword = "ligma";
            isNormalUser = true;
            extraGroups = [
              "dpigeon"
              "wheel"
              "user"
              "docker"
            ];
          };
        })
      ];
    };
in
{
  inherit flake;
}
