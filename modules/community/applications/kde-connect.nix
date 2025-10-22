{
  flake.modules.homeManager.kde-connect =
    { pkgs, ... }:
    {
      services.kdeconnect = {
        enable = true;
        package = pkgs.kdePackages.kdeconnect-kde;
      };
    };
}
