{ inputs, ... }:
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
  laptop.enable = true;
  stylix.enable = true;
  test-user.enable = true;

  # --- Build-specific ---
  system.stateVersion = "24.05";
  # system.copySystemConfiguration = true;

}
