{
  description = "DPigeon's nix config";

  inputs = {
    # Dependencies for both NixOS and Home Manager
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Just NixOS
    hardware.url = "github:nixos/nixos-hardware";

    #cosmic = {
    #  url = "github:busyboredom/cosmic-nightly-flake";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Just Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      system = if builtins ? currentSystem then builtins.currentSystem else "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      outputs = self.outputs;

    in
    {
      formatter.${system} = pkgs.nixfmt-rfc-style;

      overlays = {
        nvim-nightly = inputs.neovim-nightly.overlays.default;
        niri = inputs.niri.overlays.niri;
      };

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

      homeConfigurations."dpigeon" = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = { inherit inputs outputs; };

        modules = [
          inputs.zen-browser.homeModules.beta
          inputs.stylix.homeModules.stylix
          inputs.niri.homeModules.niri
          #({ nixpkgs.overlays = [ inputs.cosmic.overlays.default ]; })

          home/dpigeon/home.nix
        ];
      };

      nixosConfigurations.Pepper = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [ host/Pepper/configuration.nix ];
      };

      nixosConfigurations.DPigeon-MacOS = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          #({ nixpkgs.overlays = [ inputs.cosmic.overlays.default ]; })

          inputs.niri.nixosModules.niri
          inputs.stylix.nixosModules.stylix

          host/DPigeon-MacOS/configuration.nix
        ];
      };

    };
}
