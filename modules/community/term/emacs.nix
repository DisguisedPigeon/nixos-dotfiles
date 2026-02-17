{
  flake.aspects.emacs = {
    nixos = {
      services.emacs.enable = true;
    };
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.emacs ];
      };
  };
}
