# General configurations I don't expect to change

{ lib, config }:
{
  options = {
    general.enable = lib.mkEnableOption "sets general configs I don't expect to change";
  };

  config =
    let
      opts = config.general;
    in
    lib.mkIf opts.enable {
      networking = {
        hostName = "DPigeon-MacOS";
        networkmanager.enable = true;
      };
      time.timeZone = "Europe/Madrid";
      i18n.defaultLocale = "gl_ES.UTF-8";
    };
}
