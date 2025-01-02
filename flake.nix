{
  description = "DPigeon's nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs = {
      nixpkgs.follows = "nixpkgs";
      home-manager.follows = "home-manager";
    };
    flake-utils.url = "github:numtide/flake-utils";
    stylix.url = "github:danth/stylix";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      stylix,
      plasma-manager,
      flake-utils,
      zen-browser,
      ...
    }@inputs:
    flake-utils.lib.eachDefaultSystemPassThrough (
      system:
      let
        outputs = self.outputs;
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.${system}.default = pkgs.mkShell {
          buildInputs = [
            pkgs.statix
            pkgs.deadnix
            pkgs.nixd
            pkgs.nixfmt-rfc-style
            pkgs.stylua
            pkgs.treefmt
          ];
        };

        # Only in case I'm editing without the devShell
        formatter.${system} = pkgs.nixfmt-rfc-style;

        overlays = import ./overlays { inherit inputs; };

        nixosConfigurations = {
          DPigeon-MacOS = nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit
                inputs
                outputs
                ;
            };
            modules = [
              stylix.nixosModules.stylix
              ./host/DPigeon-MacOS/configuration.nix
            ];
          };
        };

        homeConfigurations = {
          "dpigeon@DPigeon-MacOS" = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            extraSpecialArgs = {
              inherit
                inputs
                outputs
                zen-browser
                system
                ;
            };
            modules = [
              stylix.homeManagerModules.stylix
              plasma-manager.homeManagerModules.plasma-manager
              ./home/DPigeon-MacOS/dpigeon/home.nix
            ];
          };
          "test@DPigeon-MacOS" = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            extraSpecialArgs = {
              inherit inputs outputs;
            };
            modules = [
              stylix.homeManagerModules.stylix
              plasma-manager.homeManagerModules.plasma-manager
              ./home/DPigeon-MacOS/test/home.nix
            ];
          };
        };
      }
    );
}
