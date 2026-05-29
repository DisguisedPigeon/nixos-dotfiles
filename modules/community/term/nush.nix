let
  nush-wrap = ../../../packages/wrapped-nush.nix;
in
{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.nush-custom = pkgs.callPackage nush-wrap { inherit inputs; };
    };

  flake.aspects.nush.homeManager =
    { pkgs, config, ... }:
    {
      # Launch nushell when running an interactive bash session.
      # This is done to inherit the environment variables.
      programs.bash = {
        enable = true;
        initExtra = ''
          if ! [ "$TERM" = "dumb" ] && [ -z "$BASH_EXECUTION_STRING" ]; then
            exec nu
          fi
        '';
      };

      programs.carapace.enable = true;
      programs.nushell.enable = true;
      programs.nushell.package = pkgs.callPackage nush-wrap {
        inherit inputs;

        zoxide = config.programs.zoxide.package;
        starship = config.programs.starship.package;
        direnv = config.programs.direnv.package;
      };
    };
}
