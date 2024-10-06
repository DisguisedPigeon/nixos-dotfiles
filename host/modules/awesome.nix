{ lib, config, ... }:
{
  config = lib.mkIf (config.graphics.enable && config.graphics.desktops.awesome) {
    services.xserver.windowManager.awesome.enable = true;
  };
}
