{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [ ./rofi.nix ];

  options = {
    hyprland-customization = {
      enable = lib.mkEnableOption "hyprland customization";
      browser = rec {
        package = lib.mkOption {
          default = pkgs."${command.default}";
          type = lib.types.package;
          description = "Default browser package";
        };
        command = lib.mkOption {
          default = "floorp";
          type = lib.types.str;
          description = "Default browser command";
        };
      };
      terminal = rec {
        package = lib.mkOption {
          default = pkgs."${command.default}";
          type = lib.types.package;
          description = "Default terminal package";
        };
        command = lib.mkOption {
          default = "kitty";
          type = lib.types.str;
          description = "Default terminal command";
        };
      };

      runner = {
        package = lib.mkOption {
          default = pkgs.rofi-wayland;
          type = lib.types.package;
          description = "Default runner package name (as in pkgs.{name}";
        };
        command = lib.mkOption {
          default = "rofi -show drun -modi run,drun,ssh -scroll-method 0 -drun-match-fields all -drun-display-format '{name}' -no-drun-show-actions -terminal wezterm -kb-cancel Alt-F1 -theme '$HOME'/.config/rofi/launcher.rasi";
          type = lib.types.str;
          description = "Default runner command";
        };
      };
      powermenu = lib.mkOption {
        type = lib.types.str;
        default = "$HOME/.config/rofi/powermenu.sh";
        description = "Default powermenu";
      };
    };
  };

  config =
    let
      opts = config.hyprland-customization;
    in
    {
      home.packages = [
        opts.browser.package
        opts.terminal.package
        opts.runner.package
        pkgs.pcmanfm
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

      services.dunst.enable = true;

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
              "battery"
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
                "10" = [ ];
              };
            };
            tray = {
              icon-size = 10;
              spacing = 10;
            };
            clock = {
              tooltip-format = "<big>{calendar}</big>";
              format-alt = "{:%d / %m / %Y}";
            };
            battery = {
              format = "{icon}";
              format-icons = [
                "󰂃"
                "󰁺"
                "󰁻"
                "󰁼"
                "󰁽"
                "󰁾"
                "󰁿"
                "󰂀"
                "󰂂"
                "󰁹"
              ];
              tooltip-format = "{capacity}% - {timeTo}";
            };
            pulseaudio = {
              format = "{volume}% {icon} ";
              format-bluetooth = "{volume}% {icon} {format_source}";
              format-bluetooth-muted = " {icon} {format_source}";
              format-muted = "0% {icon} ";
              format-source = "{volume}% ";
              format-source-muted = "";
              format-icons = {
                default = "󰕾";
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
              "$mod, F, exec, ${opts.browser.command}"
              "$mod, return, exec, ${opts.terminal.command}"
              "$mod shift, escape, exit"
              "$mod, W, killactive"
              "$mod, R, exec, ${opts.runner.command}"
              "$mod shift, P, exec, ${opts.powermenu}"
              "$mod, V, togglefloating"
              "$mod, m, fullscreen"

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
    };
}
