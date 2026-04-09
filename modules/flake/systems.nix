{ self, ... }:
let
  mkLinux = self.lib.mkLinux;
  mkLinuxArm = self.lib.mkLinuxArm;
in
{
  flake = {
    nixosConfigurations = {
      salt = mkLinux "salt" "24.05";
      pepper = mkLinuxArm "pepper" "25.05";
    };
  };
}
