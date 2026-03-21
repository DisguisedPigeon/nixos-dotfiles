{ inputs, ... }:
{
  imports = [ inputs.devenv.flakeModule ];

  flake-file.inputs = {
    devenv = {
      url = "github:cachix/devenv";
      inputs = {
        crate2nix.follows = "crate2nix";
        git-hooks.follows = "git-hooks";
      };
    };
    git-hooks.url = "github:cachix/git-hooks.nix";
    crate2nix = {
      url = "github:nix-community/crate2nix";
      inputs.crate2nix_stable.follows = "crate2nix";
    };
  };

  perSystem = {
    devenv.shells.default = {
      languages = {
        nix.enable = true;
        lua.enable = true;
      };

      enterTest = ''
        echo "Running tests"
        nix flake check
      '';

      git-hooks.hooks = {
        treefmt.enable = true;
      };

      treefmt = {
        enable = true;
        config.programs = {
          stylua.enable = true;
          nixfmt.enable = true;
          deadnix.enable = true;
          nixf-diagnose.enable = true;
          prettier.enable = true;
          taplo.enable = true;
        };
      };
    };
  };
}
