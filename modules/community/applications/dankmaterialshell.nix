{ inputs, ... }:
let
  flake.modules.nixos.dms = {
    imports = [ inputs.dms.nixosModules.dank-material-shell ];
    services.displayManager.dms-greeter = {
      enable = true;
      configHome = "/home/dpigeon";
      compositor.name = "niri";
    };
  };

  flake.modules.homeManager.dms = {
    imports = [ inputs.dms.homeModules.dank-material-shell ];
    programs.dank-material-shell.enable = true;
    programs.dank-material-shell.systemd.enable = true;
    programs.dank-material-shell.enableDynamicTheming = false;
  };

  flake-file.inputs.dms = {
    url = "github:AvengeMedia/DankMaterialShell";
    inputs.nixpkgs.follows = "nixpkgs";
  };
in
{
  inherit flake-file flake;
}
