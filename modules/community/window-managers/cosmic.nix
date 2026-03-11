{
  flake.aspects.cosmic.nixos =
    { lib, ... }:
    {
      services.desktopManager.cosmic.enable = lib.mkDefault true;
      services.system76-scheduler.enable = lib.mkDefault true;
      environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = lib.mkDefault 1;

      programs.firefox.preferences = {
        "widget.gtk.libadwaita-colors.enabled" = lib.mkDefault false;
      };
    };
}
