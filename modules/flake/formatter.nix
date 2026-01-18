{ inputs, lib, ... }:
{

  imports = [
    inputs.flake-file.flakeModules.nix-auto-follow
    inputs.flake-aspects.flakeModule
    inputs.treefmt-nix.flakeModule
  ];

  flake-file.inputs = {
    treefmt-nix.url = lib.mkDefault "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = lib.mkDefault "nixpkgs";
    flake-aspects.url = "github:vic/flake-aspects";
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
          taplo.enable = true;
        };

        settings.formatter.stylua = {
          column_width = 100;
          line_endings = "Unix";
          indent_type = "Spaces";
          indent_width = 2;
          quote_style = "ForceDouble";
          call_parentheses = "None";
          collapse_simple_statement = "Always";
          sort_requires.enabled = true;
        };

        settings.on-unmatched = lib.mkDefault "fatal";
        settings.global.excludes = [
          "resources/*.F16"
          "resources/*.png"
          "resources/*.spl"
          "LICENSE"
          "flake.lock"
          "*/flake.lock"
          ".envrc"
          ".direnv/*"
          "*/.gitignore"
        ];
      };
    };

}
