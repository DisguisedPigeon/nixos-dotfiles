{ config, lib, ... }:
{
  options = {
    kitty-customization.enable = lib.mkEnableOption "kitty customization";
  };
  config =
    let
      opts = config.kitty-customization;
    in
    lib.mkIf opts.enable {
      programs.kitty = {
        enable = true;
        settings = {
          enable_audio_bell = false;
        };
      };
    };
}
