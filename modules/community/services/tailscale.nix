{
  flake.aspects.tailscale.nixos = {
    services.tailscale = {
      enable = true;
    };
  };
}
