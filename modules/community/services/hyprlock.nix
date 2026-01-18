{ self, ... }:
{
  flake.aspects.hyprlock = {
    nixos = {
      programs.hyprlock.enable = true;
      security.pam.services.hyprlock = { };
    };

    homeManager =
      { config, ... }:
      {
        imports = with self.modules.homeManager; [ hypridle ];

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
          }
          // (
            if builtins.hasAttr "stylix" config.lib then
              let
                stylix = config.lib.stylix.colors;
              in
              {
                input-field = {
                  outer_color = "rgb(${stylix.base03})";
                  inner_color = "rgb(${stylix.base00})";
                  font_color = "rgb(${stylix.base05})";
                  fail_color = "rgb(${stylix.base08})";
                  check_color = "rgb(${stylix.base0A})";
                };
              }
            else
              {
                input-field = {
                  outer_color = "#6e6a86";
                  inner_color = "#191724)";
                  font_color = "#e0def4";
                  fail_color = "#eb6f92";
                  check_color = "#ebbcba";
                };
              }
          );
        };
      };
  };
}
