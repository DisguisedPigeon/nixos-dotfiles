{
  flake.aspects.shell.nixos =
    { lib, ... }:
    {
      environment = {
        variables.editor = lib.mkDefault "nvim";
        pathsToLink = lib.mkDefault [
          "/share/zsh"
          "/share/xdg-desktop-portal"
          "/share/applications"
        ];
      };
    };
}
