let
  flake.modules.nixos.pipewire = {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
    };
  };
in
{
  inherit flake;
}
