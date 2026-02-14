{
  inputs,
  self,
  ...
}:
let
  mkHome = self.lib.mkHome;
in
{
  flake-file.inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  imports = [ inputs.home-manager.flakeModules.home-manager ];

  flake = {
    homeConfigurations = {
      dpigeon-salt = mkHome "dpigeon" "salt" "25.05";
    };
  };
}
