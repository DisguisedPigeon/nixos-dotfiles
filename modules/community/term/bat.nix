{
  flake.aspects.bat.homeManager = {
    programs.zsh.shellAliases.cat = "bat";
    programs.bat.enable = true;
  };
}
