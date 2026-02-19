{
  flake.aspects.cosmic.nixos = {
    services.desktopManager.cosmic.enable = true;
    services.system76-scheduler.enable = true;
    environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;

    programs.firefox.preferences = {
      "widget.gtk.libadwaita-colors.enabled" = false;
    };
  };
}
