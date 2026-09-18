{
  flake.aspects.kde-connect.nixos = {
    programs.kdeconnect = {
      enable = true;
    };
  };
}
