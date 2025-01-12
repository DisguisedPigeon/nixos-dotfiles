{ config, lib, ... }:
{
  options = {
    alacritty-customization.enable = lib.mkEnableOption "ghostty customization";
  };
  config =
    let
      opts = config.alacritty-customization;
    in
    lib.mkIf opts.enable {
      programs.alacritty = {
        enable = true;
        settings.window.decorations = "None";
      };
    };
}
