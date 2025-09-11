{ outputs, pkgs, ... }:
{
  nixpkgs = {
    overlays = [
      outputs.overlays.nvim-nightly
      outputs.overlays.niri
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    image = ../../shared-files/wallpaper.png;

    polarity = "dark";

    fonts = {
      monospace = {
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF";
      };
      sansSerif = {
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF";
      };
      serif = {
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF";
      };
    };

    cursor = {
      package = pkgs.banana-cursor;
      name = "Banana";
      size = 22;
    };
  };

  qt.enable = true;

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };

  xdg = {
    enable = true;
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        common = {
          default = [ "gtk" ];
        };
        cosmic = {
          default = [
            "cosmic"
            "gtk"
          ];
        };
        hyprland = {
          default = [
            "hyprland"
            "gtk"
          ];
        };
      };
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-cosmic
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };

  programs.thunderbird = {
    enable = true;
    profiles.dpigeon = {
      isDefault = true;
    };
  };

  services.kdeconnect = {
    enable = true;
    package = pkgs.kdePackages.kdeconnect-kde;
  };

  systemd.user.startServices = "sd-switch";
  programs.home-manager.enable = true;
}
