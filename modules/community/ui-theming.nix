{
  flake.aspects.ui-theming.homeManager =
    { pkgs, lib, ... }:
    {
      gtk = {
        enable = lib.mkDefault true;
        iconTheme = {
          package = lib.mkDefault pkgs.papirus-icon-theme;
          name = lib.mkDefault "Papirus-Dark";
        };
      };

      qt.enable = lib.mkDefault true;
    };
}
