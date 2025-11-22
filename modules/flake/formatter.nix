{ inputs, lib, ... }:
{

  imports = [
    inputs.flake-file.flakeModules.nix-auto-follow
    inputs.treefmt-nix.flakeModule
  ];

  flake-file.inputs = {
    treefmt-nix.url = lib.mkDefault "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = lib.mkDefault "nixpkgs";
  };

  perSystem =
    { self', ... }:
    {
      packages.fmt = self'.formatter;
      treefmt = {
        projectRoot = inputs.flake-file;
        programs = {
          nixfmt.enable = true;
          stylua.enable = true;
          deadnix.enable = true;
          nixf-diagnose.enable = true;
          prettier.enable = true;
        };
        settings.on-unmatched = lib.mkDefault "fatal";
        settings.global.excludes = [
          "modules/*"
          "resources/DECORATE.F16"
          "LICENSE"
          "flake.lock"
          "*/flake.lock"
          "*.toml"
          "*.spl"
          "*.sug"
          "*.diff"
          "*.png"
          ".envrc"
          ".direnv/*"
          "*/.gitignore"
        ];
      };
    };

}
