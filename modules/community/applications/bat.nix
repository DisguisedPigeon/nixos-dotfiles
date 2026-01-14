let
  flake.modules.homeManager.bat = {
    programs.zsh.shellAliases.cat = "bat";
    programs.bat.enable = true;
  };
in
{
  inherit flake;
}
