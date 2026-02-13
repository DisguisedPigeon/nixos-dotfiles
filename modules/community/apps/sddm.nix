let
  wallpaper-location = "sddm-custom/wallpaper.png";
  package-location = ../../../packages/sddm-astronaut-theme.nix;
  font =
    mkDerivation: fetchzip:
    mkDerivation {
      name = "arcadeclassic-font";
      src = fetchzip {
        url = "https://www.1001fonts.com/download/arcadeclassic.zip";
        sha256 = "sha256-dsSP1KH1sb2zRvYSTuRnVLr54WavjJhyn8+RPWQJWfw=";
        stripRoot = false;
      };

      installPhase = ''
        mkdir -p $out/share/fonts
        cp -R $src $out/share/fonts/opentype/
      '';
      meta = {
        description = "Arcade-like font. Free for personal use.";
      };
    };
  gen-config =
    {
      has-stylix,
      stylix-colors,
    }:
    {
      theme = "japanese_aesthetic";
      themeConfig = {
        General =
          let
            colors =
              if has-stylix then
                {
                  text-fg = "#${stylix-colors.base05-hex}";
                  text-bg = "#${stylix-colors.base00-hex}";
                  text-bg-light = "#${stylix-colors.base01-hex}";
                  text-error = "#${stylix-colors.base08-hex}";
                  highlight-fg = "#${stylix-colors.base02-hex}";
                  white = "#${stylix-colors.base06-hex}";
                  transparent = "transparent";
                }
              else
                {
                  text-fg = "#e0def4";
                  text-bg = "#191724";
                  text-bg-light = "#1f1d2e";
                  text-error = "#eb6f92";
                  highlight-fg = "#26233a";
                  white = "#e0def4";
                  transparent = "transparent";
                };
          in
          {
            HeaderText = "Ludum perdidi\\n(╯°□°）╯︵ ┻━┻";
            FontSize = "10.0";
            Background = "/etc/${wallpaper-location}";
            Font = "arcadeclassic";
            # Colors
            HeaderTextColor = colors.text-fg;
            DateTextColor = colors.text-fg;
            TimeTextColor = colors.text-fg;

            FormBackgroundColor = colors.text-bg;
            BackgroundColor = colors.text-bg;
            DimBackgroundColor = colors.text-bg;

            LoginFieldBackgroundColor = colors.text-bg;
            PasswordFieldBackgroundColor = colors.text-bg;
            LoginFieldTextColor = colors.text-fg;
            PasswordFieldTextColor = colors.text-fg;
            UserIconColor = colors.text-fg;
            PasswordIconColor = colors.text-fg;

            PlaceholderTextColor = colors.text-fg;
            WarningColor = colors.text-error;

            LoginButtonTextColor = colors.text-fg;
            LoginButtonBackgroundColor = colors.text-bg;
            SystemButtonsIconsColor = colors.text-fg;
            SessionButtonTextColor = colors.text-fg;
            VirtualKeyboardButtonTextColor = colors.text-fg;

            DropdownTextColor = colors.text-fg;
            DropdownSelectedBackgroundColor = "#7c6f64";
            DropdownBackgroundColor = colors.text-bg;

            HighlightTextColor = colors.text-fg;
            HighlightBackgroundColor = colors.text-bg;
            HighlightBorderColor = colors.transparent;

            HoverUserIconColor = colors.white;
            HoverPasswordIconColor = colors.white;
            HoverSystemButtonsIconsColor = colors.white;
            HoverSessionButtonTextColor = colors.white;
            HoverVirtualKeyboardButtonTextColor = colors.white;
          };
      };
    };
in
{
  flake.aspects.sddm.nixos =
    {
      pkgs,
      config,
      ...
    }:
    {
      services.displayManager.sddm.enable = true;

      fonts.packages = [ (font pkgs.stdenvNoCC.mkDerivation pkgs.fetchzip) ];

      environment.systemPackages = [
        (pkgs.callPackage package-location (gen-config {
          has-stylix = builtins.hasAttr "stylix" config.lib;
          stylix-colors = config.lib.stylix.colors;
        }))
      ];

      environment.etc.${wallpaper-location}.source = ../../../resources/wallpaper.png;

      services.displayManager.sddm = {
        wayland.enable = true;

        theme = "sddm-astronaut-theme";
        package = pkgs.kdePackages.sddm;

        extraPackages = [ ];
      };
    };
}
