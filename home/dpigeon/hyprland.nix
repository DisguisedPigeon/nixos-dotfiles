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
    pcmanfm
    gvfs
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
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
        spacing = 10;
        modules-left = [
          "hyprland/workspaces"
          "sway/mode"
        ];
        modules-center = [ "clock" ];
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
        tray = {
          icon-size = 20;
          spacing = 10;
        };
        clock = {
          tooltip-format = "<big>{calendar}</big>";
          format-alt = "{:%d / %m / %Y}";
        };
        pulseaudio = {
          format = "{volume}%  {icon}  ";
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
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      "$mod" = "SUPER";

      exec-once = [
        "dunst"
        "nm-applet &"
        "hyprpaper"
        "waybar"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];

			monitor = [
				"eDP1, highres, auto, 1"
				", preferred, auto, 1"
			];

      general = {
        gaps_in = 5;
        gaps_out = 10;

        border_size = 1;

        layout = "master";
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
