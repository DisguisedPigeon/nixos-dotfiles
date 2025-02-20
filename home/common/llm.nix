{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    llm.enable = lib.mkEnableOption "enables and installs the cli for the ollama service";
  };

  config =
    let
      opts = config.llm;
    in
    lib.mkIf opts.enable {
      services.ollama = {
        enable = true;
        acceleration = "cuda";
      };

    };
}
