{
  flake.aspects.pipewire.nixos = {
    services.pipewire = {
      enable = true;

      pulse.enable = true;
      alsa.enable = true;
    };
  };
}
