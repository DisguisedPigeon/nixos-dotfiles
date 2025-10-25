let
  flake.modules.nixos.shell = {
    variables.editor = "nvim";
    environment.pathsToLink = [
      "/share/zsh"
      "/share/xdg-desktop-portal"
      "/share/applications"
    ];
  };
in
{
  inherit flake;
}
