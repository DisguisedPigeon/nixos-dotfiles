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
            backdrop = lib.mkForce "1E1E2E";
            interface = {
              branding = "DPigeon MacOS";
              helpHidden = true;
            };
            graphicalTerminal = {
              foreground = lib.mkForce "CDD6F4";
              background = lib.mkForce "FF1E1E2E";
              palette = lib.mkForce "11111B;F38BA8;A6E3A1;F9E2AF;89B4FA;F5C2E7;94E2D5;A6ADC8";

              brightBackground = lib.mkForce "313244";
              brightForeground = lib.mkForce "CDD6F4";
              brightPalette = lib.mkForce "11111B;F38BA8;A6E3A1;F9E2AF;89B4FA;F5C2E7;94E2D5;A6ADC8";
            };
          };
        };
      };
    };
}
