{ config, lib, ... }:
{
  options = {
    wezterm-customization.enable = lib.mkEnableOption "wezterm customization";
  };
  config =
    let
      opts = config.wezterm-customization;
    in
    lib.mkIf opts.enable {
      programs.wezterm = {
        enable = true;
        extraConfig = ''return {hide_tab_bar_if_only_one_tab = true}'';
      };
    };
}
