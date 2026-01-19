{
  flake.aspects.waybar.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ pavucontrol ];

      programs.waybar = {
        enable = true;
        settings = {
          mainBar = {
            position = "bottom";
            spacing = 10;

            modules-left = [ "ext/workspaces" ];
            modules-center = [ "clock" ];
            modules-right = [
              "tray"
              "network"
              "cpu"
              "battery"
              "pulseaudio"
            ];

            "ext/workspaces" = {
              format = "{icon}";
              format-icons = {
                "1" = " ";
                "2" = " ";
                "8" = " ";
                "9" = " ";
                "default" = " ";
                "empty" = " ";
              };
              ignore-hidden = true;
              on-click = "activate";
              on-click-right = "deactivate";
              sort-by-id = true;
            };

            clock = {
              tooltip-format = "<big>{calendar}</big>";
              format-alt = "{:%d / %m / %Y}";
            };

            tray = {
              icon-size = 10;
              spacing = 10;
            };

            network = {
              "interface" = "wlp3s0";
              "format" = "{ifname}";
              "format-wifi" = "󰖩 ({signalStrength}%)";
              "format-ethernet" = "󰌘 {ipaddr}/{cidr}";
              "format-disconnected" = "󰌙 ";
              "tooltip-format" = "󱘖 {ifname} via {gwaddr}";
              "tooltip-format-wifi" = "󱛁 {essid}";
              "tooltip-format-ethernet" = " {ifname}";
              "tooltip-format-disconnected" = "󰚦 ";
              "max-length" = 50;
            };

            cpu = {
              interval = 3;
              format = "{icon0}{icon1}{icon2}{icon3}{icon4}{icon5}{icon6}{icon7}";
              format-icons = [
                "<span color='#69ff94'>▁</span>"
                "<span color='#2aa9ff'>▂</span>"
                "<span color='#f8f8f2'>▃</span>"
                "<span color='#f8f8f2'>▄</span>"
                "<span color='#ffffa5'>▅</span>"
                "<span color='#ffffa5'>▆</span>"
                "<span color='#ff9977'>▇</span>"
                "<span color='#dd532e'>█</span>"
              ];
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
              format-icons.default = "󰕾";
              on-click = "pavucontrol";
            };
          };
        };
      };
    };
}
