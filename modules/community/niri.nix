{inputs, ...}:
let flake-file.inputs.niri.url = "github:sodiboo/niri-flake";
in
{
  inherit flake-file;
  flake.modules.nixos.niri = {
    programs.niri.package = niri.niri-stable;
    environment.systemPackages = lib.mkIf config.programs.niri.enable [
      pkgs.xwayland-satellite
    ];
  };
  flake.modules.homeManager.niri = {
     programs.niri.package = pkgs.niri-stable;
  };
}
