{ ... }:
{
  flake.modules.homeManager.obs =
    { config, ... }:
    {
      boot.kernelModules = [ "v4l2loopback" ];
      boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback.out ];
      boot.extraModprobeConfig = ''
        options v4l2loopback exclusive_caps=1 card_label="VirtuaCamera"
      '';
      programs.obs-studio.enable = true;
    };
}
