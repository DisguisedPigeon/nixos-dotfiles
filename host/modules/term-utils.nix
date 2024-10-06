{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    term.enable = lib.mkEnableOption "terminal setup";
  };

  config =
    let
      opts = config.term;
    in
    lib.mkIf opts.enable {
      programs.zsh.enable = true;
      environment = {
        systemPackages = [
          pkgs.neovim
          pkgs.git
        ];
        variables = {
          editor = "nvim";

        };
        pathsToLink = [
          "/share/zsh"
          "/share/xdg-desktop-portal"
          "/share/applications"
        ];
      };
    };
}
