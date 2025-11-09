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

  flake.homeConfigurations = {
    dpigeon-salt = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.self.nixosConfigurations.salt.pkgs;
      extraSpecialArgs.osConfig = inputs.self.nixosConfigurations.salt.config;
      modules = [
        inputs.self.modules.homeManager.home-manager
        inputs.self.modules.homeManager.dpigeon-salt
        {
          home.username = "dpigeon";
          home.homeDirectory = "/home/dpigeon";
          home.stateVersion = "25.05";
        }
      ];
    };
  };

in
{
  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];

  flake-file.inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  inherit flake;
}
