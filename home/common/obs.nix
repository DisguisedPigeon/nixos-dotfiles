{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    obs.enable = lib.mkEnableOption "obs config";
  };

  config =
    let
      opts = config.obs;
    in
    lib.mkIf opts.enable {
      programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          obs-webkitgtk
        ];
      };
    };
}
