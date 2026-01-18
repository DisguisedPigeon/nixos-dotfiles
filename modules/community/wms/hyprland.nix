{ inputs, ... }:
{
  flake.aspects.hyprland = {
    nixos =
      { pkgs, ... }:
      {
        imports = [ inputs.self.modules.nixos.hyprlock ];

        programs.hyprland.enable = true;
        environment.systemPackages = [ pkgs.xdg-desktop-portal-hyprland ];
      };

    homeManager =
      { pkgs, ... }:
      {
        wayland.windowManager.hyprland.enable = true;

        home.packages = with pkgs; [
          wl-clipboard
          grim
          slurp
          dunst
          rofi
        ];

        wayland.windowManager.hyprland = {
          settings = {
            "$mod" = "SUPER";

            exec-once = [
              "dunst"
              "hyprpaper"
              "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
            ];

            monitor = [
              "HDMI-A-1, highres, 0x0, 1"
              "eDP-1, highres, 1920x0, 1"
              ", preferred, auto-right, 1"
            ];

            general = {
              gaps_in = 5;
              gaps_out = 10;
              border_size = 1;
              layout = "master";
            };

            decoration = {
              rounding = 5;
              inactive_opacity = 0.9;
              blur = {
                enabled = true;
                vibrancy = 0;
                size = 10;
                passes = 2;
              };
            };

            input = {
              kb_layout = "us";
              kb_variant = "altgr-intl";
              follow_mouse = 1;
              touchpad.natural_scroll = true;
            };

            xwayland.force_zero_scaling = true;
            gesture = [ "3, horizontal, workspace" ];
            bindm = [
              "$mod,mouse:272,movewindow"
              "$mod,mouse:273,resizewindow"
            ];

            bind = [
              "$mod, F, exec, zen"
              "$mod shift, F, exec, zen -p"
              "$mod, return, exec, wezterm"
              "$mod shift, escape, exit"
              "$mod, W, killactive"
              "$mod, R, exec, rofi -show drun -modi run,drun,ssh,window"
              "$mod shift, P, exec, $HOME/.config/rofi/powermenu.sh"
              "$mod, V, togglefloating"
              "$mod, m, fullscreen"
              "$mod, Space, exec, wezterm start session-chooser"
              "$mod, h, movefocus, l"
              "$mod, l, movefocus, r"
              "$mod, k, movefocus, u"
              "$mod, j, movefocus, d"
              "$mod control, h, layoutmsg, orientationleft"
              "$mod control, j, layoutmsg, orientationbottom"
              "$mod control, k, layoutmsg, orientationtop"
              "$mod control, l, layoutmsg, orientationright"
              "$mod control, space, layoutmsg, orientationcenter"
              "$mod shift, h, movewindow, l"
              "$mod shift, l, movewindow, r"
              "$mod shift, k, movewindow, u"
              "$mod shift, j, movewindow, d"
              "$mod control, s, swapactiveworkspaces, 0 1"
              "$mod shift, down, exec, light -U 30"
              "$mod shift, up, exec, light -A 30"
              "shift, Print, exec, grim -g \"$(slurp -d)\" - | wl-copy"
            ]
            ++ (builtins.concatLists (
              builtins.genList (x: [
                "$mod, ${x}, workspace, ${toString (x + 1)}"
                "$mod shift, ${x}, movetoworkspace, ${toString (x + 1)}"
              ]) 10
            ));
          };
        };
      };
  };
}
