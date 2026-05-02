{
  flake.aspects.power-profiles.nixos = {
    services = {
      power-profiles-daemon.enable = true;
      upower.enable = true;
    };
  };
}
