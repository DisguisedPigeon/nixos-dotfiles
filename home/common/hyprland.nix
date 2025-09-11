{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [
    ./rofi.nix
    ./waybar.nix
  ];

  home.packages = [
    pkgs.wezterm
    pkgs.rofi-wayland
    pkgs.gvfs
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-hyprland
    pkgs.networkmanagerapplet
    pkgs.dunst
    pkgs.hyprlock
    pkgs.pavucontrol
    pkgs.grim
    pkgs.slurp
    pkgs.wl-clipboard
  ];

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
        "HDMI-A-1, highres, 0x0, 1"
        "eDP-1, highres, 1920x0, 1.25"
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

      xwayland = {
        force_zero_scaling = true;
      };

      gestures.workspace_swipe = true;
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
        "$mod, R, exec, rofi -show drun -modi run,drun,ssh -scroll-method 0 -drun-match-fields all -drun-display-format '{name}' -no-drun-show-actions -terminal wezterm -kb-cancel Alt-F1 -theme '$HOME'/.config/rofi/launcher.rasi"
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

  stylix.targets.hyprlock.enable = false;
  programs.hyprlock = {
    enable = true;
    settings = {
      general.hide_cursor = true;
      auth.pam.enabled = true;
      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];
      input-field = with config.lib.stylix.colors; {
        outer_color = "rgb(${base03})";
        inner_color = "rgb(${base00})";
        font_color = "rgb(${base05})";
        fail_color = "rgb(${base08})";
        check_color = "rgb(${base0A})";
      };
    };
  };

  services = {
    dunst.enable = true;

    hypridle = {
      enable = true;
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
        };

        listener = [
          {
            timeout = 200;
            on-timeout = "hyprlock";
          }
          {
            timeout = 1200;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };
}
