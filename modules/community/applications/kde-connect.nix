{
  flake.modules.homeManager.kde-connect =
    { pkgs, ... }:
    {
      services.kdeconnect.enable = true;

      services.kdeconnect.package = pkgs.kdePackages.kdeconnect-kde;
    };
}
