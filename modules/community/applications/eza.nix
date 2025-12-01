let
  flake.modules.homeManager.eza = {
    programs.zsh.shellAliases.ls = "eza";

    programs.eza = {
      enable = true;
      git = true;
      icons = "auto";
    };
  };
in
{
  inherit flake;
}
