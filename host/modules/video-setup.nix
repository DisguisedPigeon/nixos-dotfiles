{ config, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.v4l-utils
  ];
  boot = {
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback.out ];
    kernelModules = [
      "v4l2loopback"
    ];
    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
    '';
  };
}
