{ config, pkgs, ... }:
{
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gnome ];

  programs.niri = {
    enable = true;
    settings = {
      hotkey-overlay.skip-at-startup = true;

      # IO-Settings
      input = {
        keyboard.xkb = {
          layout = "us";
          variant = "altgr-intl";
          options = "esc:nocaps";
        };

        warp-mouse-to-focus = {
          enable = true;
          mode = "center-xy-always";
        };
      };

      outputs = {
        "1" = {
          name = "eDP-1";
          focus-at-startup = true;
          position = {
            x = 1280;
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
      # \IO-Settings

      # Behavior settings
      environment = {
        DISPLAY = ":0";
      };
      spawn-at-startup = [
        { command = [ "nm-applet" ]; }
        { command = [ "xwayland-satellite" ]; }
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

      binds =
        with config.lib.niri.actions;
        let
          sh = spawn "sh" "-c";
        in
        {
          # Actual keybinds
          "Mod+Shift+Escape".action = quit;
          "Mod+Shift+Slash".action = show-hotkey-overlay;
          "Mod+Space".action = spawn "wezterm start session-chooser";

          # Move stuff around
          "Mod+H".action = focus-column-left;
          "Mod+J".action = focus-workspace-down;
          "Mod+K".action = focus-workspace-up;
          "Mod+L".action = focus-column-right;

          "Mod+Ctrl+H".action = move-workspace-to-monitor-left;
          "Mod+Ctrl+J".action = move-workspace-down;
          "Mod+Ctrl+K".action = move-workspace-up;
          "Mod+Ctrl+L".action = move-workspace-to-monitor-right;

          "Mod+Shift+H".action = move-column-left;
          "Mod+Shift+J".action = move-window-to-workspace-down;
          "Mod+Shift+K".action = move-window-to-workspace-up;
          "Mod+Shift+L".action = move-column-right;

          "Mod+BracketLeft".action = focus-window-up;
          "Mod+BracketRight".action = focus-window-down;
          "Mod+Shift+BracketLeft".action = consume-or-expel-window-left;
          "Mod+Shift+BracketRight".action = consume-or-expel-window-right;
          # \Move stuff around

          "Mod+M".action = maximize-column;
          "Mod+S".action = switch-preset-column-width;
          "Mod+Print".action = screenshot { show-pointer = false; };
          "Mod+T".action = toggle-column-tabbed-display;
          "Mod+W".action = close-window;

          "Mod+Q".action = switch-focus-between-floating-and-tiling;
          "Mod+Shift+Space".action = toggle-window-floating;

          "Mod+F".action = spawn "zen";
          "Mod+Return".action = spawn "wezterm";
          "Mod+Shift+P".action = sh "$HOME/.config/rofi/powermenu.sh";
          "Mod+R".action = (
            sh "rofi -show drun -modi run,drun,ssh -scroll-method 0 -drun-match-fields all -drun-display-format '{name}' -no-drun-show-actions -terminal wezterm -kb-cancel Alt-F1 -theme .config/rofi/launcher.rasi"
          );

          "Mod+O" = {
            action = toggle-overview;
            repeat = false;
          };

          "XF86AudioRaiseVolume" = {
            allow-when-locked = true;
            action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
          };
          "XF86AudioLowerVolume" = {
            allow-when-locked = true;
            action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
          };
          "XF86AudioMute" = {
            allow-when-locked = true;
            action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
          };
          "XF86AudioMicMute" = {
            allow-when-locked = true;
            action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
          };
          # \Actual keybinds

          # Docs
          "Mod+R".hotkey-overlay.title = "Rofi launcher";
          "Mod+Shift+P".hotkey-overlay.title = "Rofi powermenu";

          "Mod+Ctrl+H".hotkey-overlay = {
            title = "Workspace to left monitor";
          };
          "Mod+Ctrl+J".hotkey-overlay = {
            title = "Move workspace down";
          };
          "Mod+Ctrl+K".hotkey-overlay = {
            title = "Move workspace up";
          };
          "Mod+Ctrl+L".hotkey-overlay = {
            title = "Workspace to right monitor";
          };

          "Mod+BracketLeft".hotkey-overlay = {
            title = "Focus window up";
          };
          "Mod+BracketRight".hotkey-overlay = {
            title = "Focus window down";
          };

          "Mod+S".hotkey-overlay = {
            title = "Change column width";
          };

          "Mod+T".hotkey-overlay = {
            title = "Toggle from stacked to tabs";
          };

          "Mod+Space".hotkey-overlay = {
            title = "Toggle focus from float to tiling";
          };
          "Mod+Shift+Space".hotkey-overlay = {
            title = "Toggle window from float to tiling";
          };
          # \Docs
        };
    };
  };
}
