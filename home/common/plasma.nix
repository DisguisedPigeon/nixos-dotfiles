{ lib, config, ... }:
{
  options = {
    plasma-customization.enable = lib.mkEnableOption "plasma config";
  };
  config =
    let
      opts = config.plasma-customization;
    in
    lib.mkIf opts.enable {
      programs.plasma = {
        enable = true;
        workspace.iconTheme = "Papirus-Dark";
        panels = [
          {
            location = "bottom";
            widgets = [
              {
                name = "org.kde.plasma.kickoff";
                config = {
                  General = {
                    icon = "nix-snowflake-white";
                    alphaSort = true;
                  };
                };
              }
              "org.kde.plasma.marginsseparator"
              {
                iconTasks = {
                  launchers = [
                    "applications:org.kde.dolphin.desktop"
                    "applications:org.kde.konsole.desktop"
                  ];
                };
              }
              "org.kde.plasma.marginsseparator"
              {
                systemTray.items = {
                  shown = [ "org.kde.plasma.battery" ];
                };
              }
              {
                digitalClock = {
                  calendar.firstDayOfWeek = "monday";
                  time.format = "24h";
                };
              }
            ];
            floating = true;
          }
        ];
      };
    };
}
