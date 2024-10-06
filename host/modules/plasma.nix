{ lib, config, ... }:
{
  config = lib.mkIf (config.graphics.enable && config.graphics.desktops.plasma) {
    services.desktopManager.plasma6.enable = true;
  };
}
