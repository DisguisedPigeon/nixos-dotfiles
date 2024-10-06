{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    laptop.enable = lib.mkEnableOption "enable laptop specific configs";
  };

  config =
    let
      opts = config.laptop;
    in
    lib.mkIf opts.enable {
      programs.light.enable = true;
      environment = {
        systemPackages = [
          pkgs.caffeine-ng
        ];
      };
    };
}
