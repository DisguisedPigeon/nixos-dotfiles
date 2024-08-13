{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  config = {
    browser = "floorp";
    terminal = "kitty";
    runner = "rofi -show drun -modi run,drun,ssh -scroll-method 0 -drun-match-fields all -drun-display-format '{name}' -no-drun-show-actions -terminal kitty -kb-cancel Alt-F1 -theme '$HOME'/.config/rofi/launcher.rasi";
    powermenu = "$HOME/.config/rofi/powermenu.sh";
  };
in
{
  imports = [ ./rofi.nix ];

  home.packages = with pkgs; [
    networkmanagerapplet
    dunst
    hyprlock
    pavucontrol
    grim
    slurp
    wl-clipboard
  ];

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        modules-left = [
          "hyprland/workspaces"
          "sway/mode"
        ];
        modules-center = [
          "clock"
          "idle_inhibitor"
        ];
        modules-right = [
          "tray"
          "pulseaudio"
        ];

        "sway/mode" = {
          format = "<span style=\"italic\">{}</span>";
        };
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "default" = "";
            "empty" = "";
          };
          persistent-workspaces = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
            "5" = [ ];
            "6" = [ ];
            "7" = [ ];
            "8" = [ ];
            "9" = [ ];
          };
        };
        network = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ifname} ";
          format-disconnected = "";
          max-length = 50;
          on-click = "kitty -e 'nmtui'";
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
          on-click = "bash /home/dg/.local/bin/toggleRemote";
        };
        tray = {
          icon-size = 15;
          spacing = 10;
        };
        clock = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          # format-alt= "{:%Y-%m-%d}"
        };
        pulseaudio = {
          format = "{volume}% {icon} ";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = "0% {icon} ";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "pavucontrol";
        };
      };
    };
    style = ./waybar-style.css;
  };

  services.hyprpaper = {
    enable = true;

    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = [ "~/Imaxes/wallpapers/Random/Paisaje_Rosa.png" ];
      wallpaper = [ ",~/Imaxes/wallpapers/Random/Paisaje_Rosa.png" ];
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 300;
      };

      background = [
        {
          path = "screenshot";
          blur_passes = 2;
          blur_size = 10;
          vibrancy = 0;
        }
      ];

      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(0, 0, 0)";
          inner_color = "rgb(8fbfbf)";
          outer_color = "rgb(8fbfbf)";
          outline_thickness = 1;
          placeholder_text = "Password: ";
          fail_text = "Failed, $ATTEMPTS left";
        }
      ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";

      exec-once = [
        "dunst"
        "nm-applet &"
        "hyprpaper"
        "waybar"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;

        border_size = 1;

        layout = "master";

        "col.inactive_border" = "rgb(3f3f7f)";
        "col.active_border" = "rgb(00ffff)";
      };

      decoration = {
        rounding = 5;
        inactive_opacity = 0.6;
        drop_shadow = true;

        blur = {
          enabled = true;
          vibrancy = 0;
          size = 10;
          passes = 2;
        };
      };

      input = {
        kb_layout = "es";
        follow_mouse = 1;
        touchpad.natural_scroll = true;
      };

      xwayland = {
        force_zero_scaling = true;
      };

      gestures.workspace_swipe = true;
      bindm = [
        "$mod,mouse:272,movewindow"
        "$mod,mouse:273,resizewindow"
      ];

      bind =
        [
          "$mod, F, exec, ${config.browser}"
          "$mod, return, exec, ${config.terminal}"
          "$mod, escape, exit"
          "$mod, W, killactive"
          "$mod, R, exec, ${config.runner}"
          "$mod shift, P, exec, ${config.powermenu}"
          "$mod, V, togglefloating"
          "$mod, m, fullscreen"

          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, k, movefocus, u"
          "$mod, j, movefocus, d"

          "$mod shift, h, movewindow, l"
          "$mod shift, l, movewindow, r"
          "$mod shift, k, movewindow, u"
          "$mod shift, j, movewindow, d"

          "$mod shift, down, exec, light -U 30"
          "$mod shift, up, exec, light -A 30"

          "shift, Print, exec, grim -g \"$(slurp -d)\" - | wl-copy"
        ]
        ++ (builtins.concatLists (
          builtins.genList (
            x:
            let
              ws =
                let
                  c = (x + 1) / 10;
                in
                builtins.toString (x + 1 - (c * 10));
            in
            [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod shift, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          ) 10
        ));
    };
  };
}
