{ inputs, ... }:
let
  wrapped-emacs = ../../../packages/wrapped-emacs.nix;
in
{
  perSystem =
    { pkgs, ... }:
    {
      packages.emacs-custom = pkgs.callPackage wrapped-emacs { inherit inputs; };
    };
}
