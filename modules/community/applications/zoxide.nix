let
  flake.modules.homeManager.zoxide= {
    programs.zoxide = {
      enable = true;
      options = ["--cmd cd"];
    };
  };
in
{
  inherit flake;
}
