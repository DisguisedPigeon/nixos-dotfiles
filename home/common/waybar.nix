{ config, lib, ... }:
{
  programs.waybar = lib.mkIf config.hyprland-customization.enable {
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
          format = "{icon}<sub> {name}</sub>";
          format-icons = {
            "1" = "";
            "2" = "";
            "9" = "";
            "10" = "";
            "default" = "";
            "empty" = "";
          };
          persistent-workspaces = {
            "1" = [ ];
            "2" = [ ];
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
}
