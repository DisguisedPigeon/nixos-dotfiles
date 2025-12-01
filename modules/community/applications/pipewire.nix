let
  flake.modules.nixos.pipewire = {
    services.pipewire.enable = true;

    services.pipewire = {
      pulse.enable = true;
      alsa.enable = true;
    };
  };
in
{
  inherit flake;
}
