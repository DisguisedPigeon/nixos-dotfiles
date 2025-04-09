{
  outputs,
  pkgs,
  lib,
  config,
  ...
}:
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
        base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
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
          terminal = 0.8;
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
