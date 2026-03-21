{ inputs, ... }:
{
  flake-file.inputs = {
    devenv.url = "github:cachix/devenv";
  };

  imports = [ inputs.devenv.flakeModule ];

  perSystem =
    { ... }:
    {
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
