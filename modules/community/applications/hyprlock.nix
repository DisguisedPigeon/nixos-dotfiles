{ inputs, ... }:
let
  flake.modules.nixos.hyprlock = {
    programs.hyprlock.enable = true;
    security.pam.services.hyprlock = { };
  };

  flake.modules.homeManager.hyprlock =
    { config, ... }:
    {
      imports = with inputs.self.modules.homeManager; [ hypridle ];
      programs.hyprlock.enable = true;

      programs.hyprlock = {
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
            { }
        );
      };
    };
in
{
  inherit flake;
}
