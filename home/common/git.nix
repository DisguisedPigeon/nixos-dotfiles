{
  lib,
  config,
  ...
}:
{
  options = {
    git-customization.enable = lib.mkEnableOption "sets up home configuration";
  };

  config =
    let
      opts = config.git-customization;
    in
    lib.mkIf opts.enable {
      programs.git = {
        enable = lib.mkDefault true;
      };

      xdg.configFile.git = {
        enable = true;
        source = ./configs/git;
      };
    };
}
