{lib, config,...}:{
  config = lib.mkIf config.graphic.enable && config.graphic.desktops.hyprland {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
