{
  flake.aspects.limine.nixos =
    { lib, ... }:
    {
      boot.loader = {
        generic-extlinux-compatible.enable = false;

        limine = {
          enable = true;

          extraEntries = lib.mkDefault "";
          maxGenerations = 5;

          additionalFiles.font = ../../../resources/DECORATE.F16;

          extraConfig = ''
            term_font: boot():/font
            default_entry: 2
            interface_branding_colour: C4A7E7
            interface_help_hidden: yes
            # Colors for the booting in [n] seconds prompt.
            interface_help_colour_bright: 9CCFD8
            interface_help_colour: 31748F
          '';

          style = {
            wallpapers = [ ../../../resources/wallpaper.png ];

            backdrop = lib.mkForce "1E1E2E";
            interface.branding = "DPigeon's Salt";

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
