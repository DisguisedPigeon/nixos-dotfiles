{
  flake.aspects.eza.homeManager = {
    programs.zsh.shellAliases.ls = "eza";

    programs.eza = {
      enable = true;
      git = true;
      icons = "auto";
    };
  };
}
