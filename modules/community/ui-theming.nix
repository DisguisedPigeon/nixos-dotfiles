{
  flake.aspects.ui-theming.homeManager =
    { pkgs, ... }:
    {
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
