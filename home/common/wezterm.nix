{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    wezterm-customization.enable = lib.mkEnableOption "wezterm customization";
  };
  config =
    let
      opts = config.wezterm-customization;
    in
    lib.mkIf opts.enable {
      xdg.configFile.wezterm = {
        enable = true;
        source = ./configs/wezterm;
        recursive = true;
      };
      home.packages = with pkgs; [
        wezterm
      ];
    };
}
