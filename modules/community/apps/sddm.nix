let
  wallpaper-location = "sddm-custom/wallpaper.png";
  sddm-astronaut-theme = ../../../packages/sddm-astronaut-theme.nix;
  arcadeclassic-font = ../../../packages/arcadeclassic-font.nix;
  colors = {
    text-fg = "#e0def4";
    text-bg = "#191724";
    text-bg-light = "#1f1d2e";
    text-error = "#eb6f92";
    highlight-fg = "#26233a";
    white = "#e0def4";
    transparent = "transparent";
  };
  themeConfig = {
    General = {
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
in
{
  perSystem =
    { pkgs, ... }:
    {
      packages.sddm-custom = pkgs.callPackage sddm-astronaut-theme {
        theme = "japanese_aesthetic";
        inherit themeConfig;
      };
    };
  flake.aspects.sddm.nixos =
    { pkgs, ... }:
    {
      fonts.packages = [ (pkgs.callPackage arcadeclassic-font { }) ];

      environment.systemPackages = [
        (pkgs.callPackage sddm-astronaut-theme {
          theme = "japanese_aesthetic";
          inherit themeConfig;
        })
      ];

      environment.etc.${wallpaper-location}.source = ../../../resources/wallpaper.png;

      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;

        theme = "sddm-astronaut-theme";
        package = pkgs.kdePackages.sddm;

        extraPackages = with pkgs; [
          kdePackages.qtmultimedia
        ];
      };
    };
}
