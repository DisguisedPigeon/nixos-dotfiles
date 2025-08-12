{
  programs.niri = {
    enable = true;
    settings = {
      spawn-at-startup = [
        { command = [ "nm-applet" ]; }
        { command = [ "hyprpaper" ]; }
        { command = [ "waybar" ]; }
        {
          command = [
            "dbus-update-activation-environment"
            "--systemd"
            "WAYLAND_DISPLAY"
            "XDG_CURRENT_DESKTOP"
          ];
        }
      ];

      outputs = {
        "1" = {
          name = "eDP-1";
          focus-at-startup = true;
          position = {
            x = 0;
            y = 0;
          };
          scale = 1.25;

        };

        "2" = {
          name = "HDMI-A-1";
          focus-at-startup = true;
          position = {
            x = 1536;
            y = 0;
          };
          scale = 1;
        };
      };

      input.keyboard.xkb = {
        layout = "us";
        variant = "altgr-intl";
      };

    };
  };
}
