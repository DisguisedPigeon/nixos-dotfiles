{
  outputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  theme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
in
{
  options = {
    default_home.enable = lib.mkEnableOption "sets up home configuration";
  };

  config =
    let
      opts = config.default_home;
    in
    lib.mkIf opts.enable {
      nixpkgs = {
        overlays = [
          outputs.overlays.additions
          outputs.overlays.modifications
          outputs.overlays.nvim-nightly
        ];
        config = {
          allowUnfree = true;
        };
      };
      home.packages = [ pkgs.banana-cursor ];

      stylix = {
        enable = lib.mkDefault true;
        # base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
        base16Scheme = lib.mkDefault theme;
        # image = lib.mkDefault wallpaper;
        image = lib.mkDefault ./configs/wallpaper.png;
        cursor = {
          package = lib.mkDefault pkgs.banana-cursor;
          name = lib.mkDefault "Banana";
          size = lib.mkDefault 22;
        };
        fonts = {
          monospace = {
            package = lib.mkDefault pkgs.maple-mono-NF;
            name = lib.mkDefault "Maple Mono NF";
          };
          sansSerif = {
            package = lib.mkDefault pkgs.dejavu_fonts;
            name = lib.mkDefault "DejaVu Sans";
          };
          serif = {
            package = lib.mkDefault pkgs.dejavu_fonts;
            name = lib.mkDefault "DejaVu Serif";
          };
        };
        polarity = lib.mkDefault "dark";
        opacity = {
          terminal = 0.9;
        };

      };

      gtk.enable = lib.mkDefault true;
      gtk.iconTheme.package = lib.mkDefault pkgs.papirus-icon-theme;
      gtk.iconTheme.name = lib.mkDefault "Papirus-Dark";
      qt.enable = lib.mkDefault true;

      xdg = {
        enable = lib.mkDefault true;
        portal = {
          enable = true;
          xdgOpenUsePortal = true;
          configPackages = lib.mkDefault [
            pkgs.xdg-desktop-portal-hyprland
          ];
          config = {
            common = {
              default = [ "gtk" ];
            };
            hyprland = {
              default = [
                "hyprland"
                "gtk"
              ];
            };
          };
          extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
        };
      };

      programs.thunderbird = {
        enable = lib.mkDefault false;
        profiles.dpigeon = {
          isDefault = true;
        };
      };

      programs.chromium = {
        enable = lib.mkDefault false;
        extensions = [
          "epcnnfbjfcgphgdmggkamkmgojdagdnn" # ublock
          "eimadpbcbfnmbkopoojfekhnkhdbieeh" # dark reader
          "cfemcmeknmapecneeeaajnbhhgfgkfhp" # darkpdf
          "enpfonmmpgoinjpglildebkaphbhndek" # Tokyonight-ish
        ];
      };

      programs.yazi.enable = lib.mkDefault false;

      services.kdeconnect = {
        enable = lib.mkDefault true;
        package = pkgs.kdePackages.kdeconnect-kde;
      };

      # auto-restarts/stops all services as declared by the home-manager config
      systemd.user.startServices = "sd-switch";

      programs.home-manager.enable = true;

    };
}

# base 16 theme example
#base16theme = {
#  system = "base16";
#  name = "catppuccin-mocha-custom";
#  slug = "catppuccin-mocha-custom";
#  palette = {
#    base00 = "#000000";
#    base01 = "#11111b";
#    base02 = "#313244";
#    base03 = "#45475a";
#    base04 = "#585b70";
#    base05 = "#cdd6f4";
#    base06 = "#f5e0dc";
#    base07 = "#b4befe";
#    base08 = "#f38ba8";
#    base09 = "#fab387";
#    base0A = "#f9e2af";
#    base0B = "#a6e3a1";
#    base0C = "#94e2d5";
#    base0D = "#89b4fa";
#    base0E = "#cba6f7";
#    base0F = "#f2cdcd";
#  };
#};
