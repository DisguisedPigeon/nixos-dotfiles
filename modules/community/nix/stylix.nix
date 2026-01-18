{ inputs, ... }:
let
  image = ../../../resources/wallpaper.png;
  stylix_config = pkgs: {
    inherit image;
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

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
in
{
  flake-file.inputs.stylix = {
    url = "github:danth/stylix";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-parts.follows = "flake-parts";
    inputs.systems.follows = "systems";
  };

  flake.aspects.stylix = {
    nixos =
      { pkgs, ... }:
      {
        imports = [ inputs.stylix.nixosModules.stylix ];
        stylix = (stylix_config pkgs);
      };
    homeManager =
      { pkgs, ... }:
      {
        imports = [
          inputs.stylix.homeModules.stylix
          inputs.self.modules.homeManager.ui-theming
        ];

        stylix = (stylix_config pkgs) // {
          targets.zen-browser.enable = false;
          targets.hyprlock.enable = false;
          targets.gtk.enable = false;
        };
      };
  };
}
