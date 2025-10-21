{ inputs, ... }:
let
  flake-file.inputs.niri.url = "github:sodiboo/niri-flake";
in
{
  inherit flake-file;
  flake.modules.nixos.niri =
    { pkgs, ... }:
    {
      programs.niri.package = inputs.niri.niri-stable;
      environment.systemPackages = [ pkgs.xwayland-satellite ];
    };

  flake.modules.homeManager.niri = {
    programs.niri.package = inputs.niri.niri-stable;
  };
}
