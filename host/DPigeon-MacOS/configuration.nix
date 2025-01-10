{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    inputs.hardware.nixosModules.asus-zephyrus-ga502
    ./hardware-configuration.nix
    ../modules/system-setup.nix
  ];
  # --- Custom modules config ---
  dev.enable = true;
  dualboot.enable = true;
  graphics = {
    enable = true;
    desktops = {
      plasma = true;
      awesome = true;
    };
  };

  services.flatpak.enable = true;
  boot = {
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback.out ];
    kernelModules = [
      "v4l2loopback"
    ];
    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
    '';
  };
  environment.systemPackages = [
    pkgs.v4l-utils
  ];

  laptop.enable = true;
  stylix.enable = true;
  test-user.enable = true;
  general.hostname = "DPigeon-MacOS";

  # --- Build-specific ---
  system.stateVersion = "24.05";
  # system.copySystemConfiguration = true;

}
