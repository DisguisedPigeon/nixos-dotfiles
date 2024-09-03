{
  outputs,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./zsh.nix
    ./nvim.nix
    ./kitty.nix
    ./hyprland.nix
    ./starship.nix
    ./plasma.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      # neovim-nightly-overlay.overlays.default
    ];
    config = {
      allowUnfree = true;
    };
  };

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyodark-terminal.yaml";
    image = ./configs/wallpaper.png;
    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Ice";
    cursor.size = 16;
    fonts = {
      monospace = {
        package = pkgs.maple-mono-NF;
        name = "Maple Mono NF";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
    };
    opacity = {
      terminal = 0.8;
    };
    polarity = "dark";
  };

  gtk.enable = true;
  gtk.iconTheme.package = pkgs.papirus-icon-theme;
  gtk.iconTheme.name = "Papirus";

  xdg.enable = true;

  home = {
    pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
    };
    username = "dpigeon";
    homeDirectory = "/home/dpigeon";
    packages = with pkgs; [
      steam
			gimp
      floorp
      discord
      amule
      transmission_4-qt
      syncplay
      inkscape
      vlc
      tor-browser
      kdePackages.kdeconnect-kde
      spotify
      youtube-music
    ];
  };

	programs.qutebrowser.enable = true;

	programs.chromium = {
		enable = true;
		extensions = [
			"epcnnfbjfcgphgdmggkamkmgojdagdnn" # ublock
			"eimadpbcbfnmbkopoojfekhnkhdbieeh" # dark reader
		];
	};

  programs.git = {
    enable = true;
    extraConfig = {
      safe.directory = "/home/.nixos-config";
    };
  };

  programs.yazi.enable = true;

  services.kdeconnect = {
    enable = true;
    package = pkgs.kdePackages.kdeconnect-kde;
  };

  services.caffeine.enable = true;

  systemd.user.startServices = "sd-switch";

  programs.home-manager.enable = true;

  home.stateVersion = "23.05";
}
