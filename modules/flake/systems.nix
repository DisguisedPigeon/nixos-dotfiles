{ inputs, ... }:
let
  inherit (inputs.self.lib.mk-os)
    linux
    linux-arm
    ;

  flake.nixosConfigurations = {
    salt = linux "salt";
    pepper = linux-arm "pepper";
  };

in
{
  inherit flake;
}
