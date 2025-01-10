{ config, lib, ... }:
{
  options = {
    yazi-customization.enable = lib.mkEnableOption "ghostty customization";
  };
  config =
    let
      opts = config.yazi-customization;
    in
    lib.mkIf opts.enable {
      programs.yazi = {
        enable = true;
      };
    };
}
