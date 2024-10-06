{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    test-user.enable = lib.mkEnableOption "enables the a test user";
  };
  config =
    let
      opts = config.test-user;
    in
    lib.mkIf opts.enable {
      users.users = {
        test = {
          shell = pkgs.zsh;
          initialPassword = "ligma";
          isNormalUser = true;
          extraGroups = [ "configEditor" ];
        };
      };
    };
}
