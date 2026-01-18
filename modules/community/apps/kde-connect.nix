{
  flake.aspects.kde-connect.homeManager =
    { pkgs, ... }:
    {
      services.kdeconnect = {
        enable = true;
        package = pkgs.kdePackages.kdeconnect-kde;
      };
    };
}
