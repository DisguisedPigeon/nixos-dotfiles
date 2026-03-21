# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  description = "DPigeon's NixOS Config";

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

  inputs = {
    crate2nix = {
      url = "github:nix-community/crate2nix";
      inputs.crate2nix_stable.follows = "crate2nix";
    };
    devenv = {
      url = "github:cachix/devenv";
      inputs = {
        crate2nix.follows = "crate2nix";
        git-hooks.follows = "git-hooks";
      };
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-aspects.url = "github:vic/flake-aspects";
    flake-file.url = "github:vic/flake-file";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs-lib";
    };
    git-hooks.url = "github:cachix/git-hooks.nix";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    import-tree.url = "github:vic/import-tree";
    mango = {
      url = "github:DreamMaoMao/mangowc";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs = {
        niri-stable.follows = "niri-raw";
        niri-unstable.follows = "niri-raw";
        nixpkgs.follows = "nixpkgs";
        xwayland-satellite-stable.follows = "xwayland-satellite";
        xwayland-satellite-unstable.follows = "xwayland-satellite";
      };
    };
    niri-raw.url = "github:YaLTeR/niri";
    nix-auto-follow = {
      url = "github:fzakaria/nix-auto-follow";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-sweep.url = "github:jzbor/nix-sweep";
    nix-wrappers.url = "github:BirdeeHub/nix-wrapper-modules";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-lib.follows = "nixpkgs";
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };
    treefmt-nix.url = "github:numtide/treefmt-nix";
    xwayland-satellite.url = "github:Supreeeme/xwayland-satellite";
    zen = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };
  };
}
