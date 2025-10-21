{ inputs, ... }:
let
  flake-file.inputs.stylix.url = "github:danth/stylix";
  image = ./wallpaper.jpg;
  stylix_opts = pkgs: {
    inherit image;
    enable = true;

    targets.zen-browser.profileNames = [
      "default"
      "music"
    ];

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
      stylix = stylix_opts pkgs;
    };
  flake.modules.homeManager.stylix =
    { pkgs, ... }:
    {
      imports = [
        inputs.self.flake.modules.homeManager.decorations
      ];
      stylix = stylix_opts pkgs;
    };
}
