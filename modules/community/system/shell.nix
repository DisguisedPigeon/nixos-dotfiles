{
  flake.aspects.shell.nixos = {
    environment = {
      variables.editor = "nvim";
      pathsToLink = [
        "/share/zsh"
        "/share/xdg-desktop-portal"
        "/share/applications"
      ];
    };
  };
}
