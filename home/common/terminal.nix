{ lib, config, ... }:
{
  config =
    lib.mkIf config.zsh-customization.enable
      {
      };
}
