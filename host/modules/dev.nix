{
  config,
  lib,
  ...
}:
{
  options = {
    dev.enable = lib.mkEnableOption "enables dev environment";
  };

  config =
    let
      opts = config.dev;
    in
    lib.mkIf opts.enable {
      virtualisation.docker.enable = true;
      users.users.dpigeon.extraGroups = [ "docker" ];
    };
}
