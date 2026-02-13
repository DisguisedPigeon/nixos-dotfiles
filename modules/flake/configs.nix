{
  inputs,
  self,
  ...
}:
let
  linux = self.lib.mk-os.linux;
  linux-arm = self.lib.mk-os.linux-arm;
  home = self.lib.mk-home.mkHome;
in
{
  imports = [ inputs.home-manager.flakeModules.home-manager ];

  flake-file.inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake = {
    nixosConfigurations = {
      salt = linux "salt";
      pepper = linux-arm "pepper";
    };

    homeConfigurations = {
      dpigeon-salt = home "dpigeon" "salt" "25.05";

      # old = inputs.home-manager.lib.homeManagerConfiguration {
      #   pkgs = self.nixosConfigurations.salt.pkgs;
      #   extraSpecialArgs.osConfig = self.nixosConfigurations.salt.config;
      #   modules = [
      #     self.modules.homeManager.home-manager
      #     self.modules.homeManager.dpigeon-salt
      #     {
      #       home.username = "dpigeon";
      #       home.homeDirectory = "/home/dpigeon";
      #       home.stateVersion = "25.05";
      #     }
      #   ];
      # };
    };
  };
}
