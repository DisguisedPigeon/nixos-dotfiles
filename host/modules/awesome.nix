{lib, config, ... }:
{
  config = lib.mkIf config.graphic.enable && config.graphic.desktops.awesome {
    services.xserver.windowManager.awesome.enable = true;
  };
}
