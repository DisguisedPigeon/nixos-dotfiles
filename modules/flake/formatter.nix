{
  perSystem.treefmt.projectRootFile = "flake.nix";
  perSystem.treefmt.programs = {
    nixfmt.enable = true;
    nixfmt.excludes = [ ".direnv" ];
    deadnix.enable = true;
    # kdlfmt.enable = true;
  };
}
