{ inputs, lib, ... }:
{
  flake-file.inputs = {
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem.treefmt = {
    projectRoot = inputs.flake-file;
    programs = {
      stylua.enable = true;

      nixfmt.enable = true;
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
}
