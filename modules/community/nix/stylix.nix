{ ... }:
{
  # flake-file.inputs.stylix = {
  #   url = "github:danth/stylix";
  # };

  flake.aspects.stylix = {
    nixos =
      { ... }:
      {
        # imports = [ inputs.stylix.nixosModules.stylix ];
        # stylix = stylix_config pkgs;
      };
    homeManager =
      { ... }:
      {
        #imports = [ inputs.stylix.homeModules.stylix ];

        # stylix = (stylix_config pkgs) // {
        #   targets.firefox.profileNames = [ "default" ];
        #   targets.zen-browser.enable = false;
        #   targets.hyprlock.enable = false;
        #   targets.gtk.enable = false;
        # };
      };
  };
}
