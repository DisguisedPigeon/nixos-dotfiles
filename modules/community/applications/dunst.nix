let
  flake.modules.homeManager.dunst = {
    services.dunst.enable = true;
  };
in
{
  inherit flake;
}
