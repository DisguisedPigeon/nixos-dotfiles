{lib, config,  ... }:
{
  config = lib.mkIf config.graphic.enable && config.graphic.desktops.plasma {
    services.desktopManager.plasma6.enable = true;
  };
}
