{inputs, ...}:
{

  flake.modules.homeManager.decorations= {
    gtk = {
      enable = true;
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };
    };

    qt.enable = true;
  };
}
