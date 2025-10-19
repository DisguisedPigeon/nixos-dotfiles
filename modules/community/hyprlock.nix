{inputs, ...}:
{
  flake.modules.nixos.hyprlock = {
    security.pam.services.hyprlock = {};
  };

  flake.modules.homeManager.hyprlock = {
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
        input-field = with inputs.self.config.lib.stylix.colors; {
          outer_color = "rgb(${base03})";
          inner_color = "rgb(${base00})";
          font_color = "rgb(${base05})";
          fail_color = "rgb(${base08})";
          check_color = "rgb(${base0A})";
        };
      };
    };
  };
}
