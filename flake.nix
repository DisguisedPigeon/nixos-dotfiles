{
  description = "A very basic flake";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixos-hardware, home-manager}: {
    nixosConfigurations = {
      DPigeon-MacOS = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = 
          let init = pkg : import pkg {
            inherit system;
            config.allowUnfree = true; 
          }; 
        in {
          pkgs-unstable = init nixpkgs-unstable; 
          pkgs = init nixpkgs;
        };
        modules = [
          ./hardware-configuration.nix
          ./configuration.nix
          nixos-hardware.nixosModules.asus-zephyrus-ga502
          home-manager.nixosModules.home-manager{
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.dpigeon = import ./users/dpigeon-home.nix;
            home-manager.extraSpecialArgs = 
              let init = pkg : import pkg {
                inherit system;
                config.allowUnfree = true; 
              }; 
              in {
                pkgs-unstable = init nixpkgs-unstable; 
                pkgs = init nixpkgs;
              };

          }
        ];
      };
    };
  };
}
