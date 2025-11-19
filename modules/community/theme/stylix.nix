{ inputs, ... }:
let
  flake-file.inputs.stylix = {
    url = "github:danth/stylix";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-parts.follows = "flake-parts";
    inputs.systems.follows = "systems";
  };
  image = ../../../resources/wallpaper.png;
  stylix = pkgs: {
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
  inherit flake-file;

  flake.modules.nixos.stylix =
    { pkgs, ... }:
    {
      imports = [ inputs.stylix.nixosModules.stylix ];
      environment.systemPackages = [ pkgs.banana-cursor ];
      stylix = (stylix pkgs);
    };
  flake.modules.homeManager.stylix =
    { pkgs, ... }:
    {
      imports = [
        inputs.stylix.homeModules.stylix
        inputs.self.modules.homeManager.decorations
      ];
      stylix = (stylix pkgs) // {
        targets.zen-browser.enable = false;
        targets.hyprlock.enable = false;
      };
    };
}
