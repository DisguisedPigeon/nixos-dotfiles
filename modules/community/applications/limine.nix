{ inputs, ... }:
{
  flake.modules.nixos.limine =
    { lib, ... }:
    {
      imports = with inputs.self.modules.nixos; [ boot ];
      boot.loader = {
        generic-extlinux-compatible.enable = false;
        limine = {

          enable = true;
          extraEntries = lib.mkDefault "";

          maxGenerations = 5;
          additionalFiles = {
            "font" = ../../../resources/DECORATE.F16;
          };
          extraConfig = ''
            term_font = boot():/font
            remember_last_entry:yes
          '';
          style = {
            wallpapers = [ ../../../resources/wallpaper.png ];
            wallpaperStyle = "centered";
            backdrop = "1E1E2E";
            interface = {
              branding = "DPigeon MacOS";
              helpHidden = true;
            };
            graphicalTerminal = {
              foreground = "CDD6F4";
              background = "FF1E1E2E";
              palette = builtins.concatStringsSep ";" [
                "11111B" # Black
                "F38BA8" # Red
                "A6E3A1" # Green
                "F9E2AF" # Brown (yellow??)
                "89B4FA" # Blue
                "F5C2E7" # Magenta (Pink)
                "94E2D5" # Cyan (Teal)
                "A6ADC8" # Gray (Subtext 0)
              ];

              brightBackground = "313244";
              brightForeground = "CDD6F4";
              brightPalette = builtins.concatStringsSep ";" [
                "11111B" # Black
                "F38BA8" # Red
                "A6E3A1" # Green
                "F9E2AF" # Brown (yellow??)
                "89B4FA" # Blue
                "F5C2E7" # Magenta (Pink)
                "94E2D5" # Cyan (Teal)
                "A6ADC8" # Gray (Subtext 0)
              ];
            };
          };
        };
      };
    };
}
