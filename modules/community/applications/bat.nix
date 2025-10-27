let
  flake.modules.homeManager.bat =
    { pkgs, ... }:
    {
      programs.zsh.shellAliases.cat = "bat";
      programs.bat.enable = true;
    };
in
{
  inherit flake;
}
