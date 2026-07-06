{
  flake.aspects.ui-theming = {
    nixos = { pkgs, ... }: {
      environment = {
        systemPackages = [ pkgs.banana-cursor ];
        variables.XCURSOR_SIZE = 22;
      };
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
        home.pointerCursor = {
          name = "Banana";
          size = 22;
          package = pkgs.banana-cursor;
          x11.enable = true;
          gtk.enable = true;
        };
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
