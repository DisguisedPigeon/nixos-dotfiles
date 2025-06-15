{
  description = "DPigeon's nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

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
        overlays.nvim-nightly = inputs.neovim-nightly.overlays.default;

        nixosConfigurations = {
          DPigeon-MacOS = nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs outputs;
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
              ./home/DPigeon-MacOS/dpigeon/home.nix
            ];
          };
        };

        formatter.${system} = pkgs.nixfmt-rfc-style;

        devShells.${system}.default = pkgs.mkShell {
          buildInputs = [
            # Nix stuff
            pkgs.statix
            pkgs.deadnix
            pkgs.nil
            pkgs.nixd
            pkgs.nixfmt-rfc-style

            # Lua stuff
            pkgs.stylua
            pkgs.lua-language-server

            pkgs.treefmt
          ];
        };
      }
    );
}
