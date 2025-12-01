{
  flake.modules.nixos.shell = {
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
