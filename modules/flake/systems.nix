{ inputs, self, ... }:
let
  mkLinux = self.lib.mkLinux;
  mkLinuxArm = self.lib.mkLinuxArm;
in
{
  flake-file.inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  imports = [ inputs.home-manager.flakeModules.home-manager ];

  flake = {
    nixosConfigurations = {
      salt = mkLinux "salt" "24.05";
      pepper = mkLinuxArm "pepper" "25.05";
    };
  };
}
