let
  wallpaper-location = "sddm-wallpaper.png";
  flake.modules.nixos.sddm =
    { pkgs, config, ... }:
    let
      wallpaper-location = "sddm-wallpaper.png";

      sddm-astronaut-pkg = pkgs.callPackage ../../../packages/sddm-astronaut-theme.nix {
        theme = "japanese_aesthetic";
        themeConfig = {
          General =
            let
              colors =
                if builtins.hasAttr "stylix" config.lib then
                  let
                    stylix = config.lib.stylix.colors;
                  in
                  {
                    text-fg = "#${stylix.base05-hex}";
                    text-bg = "#${stylix.base00-hex}";
                    text-bg-light = "#${stylix.base01-hex}";
                    text-error = "#${stylix.base08-hex}";
                    highlight-fg = "#${stylix.base02-hex}";
                    white = "#${stylix.base06-hex}";
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

      font = pkgs.stdenvNoCC.mkDerivation {
        name = "arcadeclassic-font";
        src = pkgs.fetchzip {
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
    in
    {
      services.displayManager.sddm.enable = true;

      fonts.packages = [ font ];

      environment.systemPackages = [
        sddm-astronaut-pkg
      ];

      environment.etc.${wallpaper-location}.source = ../../../resources/wallpaper.png;

      services.displayManager.sddm = {
        wayland.enable = true;

        theme = "sddm-astronaut-theme";
        package = pkgs.kdePackages.sddm;

        extraPackages = with pkgs.kdePackages; [
          qtmultimedia
          qtsvg
          qtvirtualkeyboard
        ];
      };
    };
in
{
  inherit flake;

  perSystem =
    { pkgs, ... }:
    {
      packages.sddm-astronaut-pkg = pkgs.callPackage ../../../packages/sddm-astronaut-theme.nix {
        theme = "japanese_aesthetic";
        themeConfig = {
          General = {
            HeaderText = "Hi";
            FontSize = "10.0";
            Background = "/etc/${wallpaper-location}";
          };
        };
      };
      packages.electroharmonix = pkgs.stdenvNoCC.mkDerivation {
        name = "electroharmonix-font";
        src = pkgs.fetchzip {
          url = "https://www.1001fonts.com/download/electroharmonix.zip";
          sha256 = "sha256-lSuwSmqMfllsEn3oZ67HPuI133T6X5AH/JeGGSFsfe8=";
          stripRoot = false;
        };

        installPhase = ''
          mkdir -p $out/share/fonts
          cp -R $src $out/share/fonts/opentype/
        '';
        meta = {
          description = "A Gill Sans Font Family derivation.";
        };
      };
    };
}
