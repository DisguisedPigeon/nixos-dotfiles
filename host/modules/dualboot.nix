{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    dualboot.enable = lib.mkEnableOption "enables dualboot support.";
  };
  config =
    let
      opts = config.dualboot;
    in
    lib.mkIf opts.enable {
      boot.loader.grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };
      boot.loader.efi.canTouchEfiVariables = true;
      environment = {
        systemPackages = [
          pkgs.ntfs3g
        ];
      };
    };
}
