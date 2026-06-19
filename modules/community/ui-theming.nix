{
  flake.aspects.ui-theming = {
    nixos = { pkgs, ... }: {
      fonts = {
        packages = with pkgs; [ maple-mono.NF ];

        fontconfig = {
          defaultFonts = {
            serif = [ "Maple Mono NF" ];
            sansSerif = [ "Maple Mono NF" ];
            monospace = [ "Maple Mono NF" ];
          };
        };
      };
    };
    homeManager =
      { pkgs, lib, ... }:
      {
        gtk = {
          enable = lib.mkDefault true;
          iconTheme = {
            package = lib.mkDefault pkgs.papirus-icon-theme;
            name = lib.mkDefault "Papirus-Dark";
          };
        };

        qt.enable = lib.mkDefault true;
      };
  };
}
