{ inputs, ... }:
let
  flake-file.inputs.stylix.url = "github:danth/stylix";
  image = ../../../resources/wallpaper.jpeg;
  stylix_opts = pkgs: {
    inherit image;
    enable = true;

    targets =
      if builtins.hasAttr "zen-browser" inputs then
        {
          zen-browser.profileNames = [
            "default"
            "music"
          ];
        }
      else
        { };

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
      stylix = stylix_opts pkgs;
    };
  flake.modules.homeManager.stylix =
    { pkgs, ... }:
    {
      imports = [
        inputs.stylix.homeModules.stylix
        inputs.self.flake.modules.homeManager.decorations
      ];
      stylix = stylix_opts pkgs;
    };
}
