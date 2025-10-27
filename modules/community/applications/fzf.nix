let
  flake.modules.homeManager.fzf = {
    programs.fzf.enable = true;
  };
in
{
  inherit flake;
}
