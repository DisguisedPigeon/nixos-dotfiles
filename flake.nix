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
    stylix.url = "github:danth/stylix";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      stylix,
      plasma-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          statix
          deadnix
          nil
          nixfmt-rfc-style
        ];
      };

      packages = import ./pkgs nixpkgs.legacyPackages.x86_64-linux;

      overlays = import ./overlays { inherit inputs; };

      nixosModules = import ./modules/nixos;

      homeManagerModules = import ./modules/home-manager;

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
            inherit inputs outputs;
          };
          modules = [
            stylix.homeManagerModules.stylix
            plasma-manager.homeManagerModules.plasma-manager
            ./home/dpigeon/home.nix
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
            ./home/test/home.nix
          ];
        };
      };
      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
