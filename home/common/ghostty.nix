{ config, lib, ... }:
{
  options = {
    ghostty-customization.enable = lib.mkEnableOption "ghostty customization";
  };
  config =
    let
      opts = config.ghostty-customization;
    in
    lib.mkIf opts.enable {
      programs.ghostty = {
        enable = true;
        settings = {
          window-decoration = false;
          background-opacity = 1;
        };
      };
    };
}
