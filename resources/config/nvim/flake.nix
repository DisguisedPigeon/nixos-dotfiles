{
  inputs = {
    devenv.url = "github:cachix/devenv";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nvim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devenv.flakeModule
        inputs.treefmt-nix.flakeModule
      ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      perSystem =
        { pkgs, inputs', ... }:
        {
          devenv.shells.default = {
            env.NVIM_APPNAME = "nvim3";

            languages = {
              lua.enable = true;
              nix.enable = true;
            };

            packages = [
              pkgs.tree-sitter
              inputs'.nvim-nightly.packages.default
            ];

            treefmt = {
              enable = true;
              config = {
                programs = {
                  stylua.enable = true;

                  nixfmt.enable = true;
                  deadnix.enable = true;
                  nixf-diagnose.enable = true;
                };
                settings.formatter = {
                  stylua = {
                    column_width = 100;
                    line_endings = "Unix";
                    indent_type = "Spaces";
                    indent_width = 2;
                    quote_style = "ForceDouble";
                    call_parentheses = "None";
                    collapse_simple_statement = "Always";
                    sort_requires.enabled = true;
                  };
                };
              };
            };

            scripts.treesitter-cli.exec = ''
              treesitter "$@";
            '';
          };
        };
    };
}
# vim: ts=2 sts=2 sw=2 et
