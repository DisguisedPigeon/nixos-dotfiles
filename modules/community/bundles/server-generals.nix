{ inputs, ... }:
let
  flake.modules.nixos.server = {
    imports = with inputs.self.modules.nixos; [
      ssh-server
      docker
    ];
  };
in
{
  inherit flake;
}
