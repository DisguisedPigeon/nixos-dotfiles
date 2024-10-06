{ inputs, ... }:
{
  imports = [
    inputs.hardware.nixosModules.raspberry-pi-4
    ../modules/system-setup.nix
  ];
  # --- Custom modules config ---
  dev.enable = true;
  dualboot.enable = true;
  stylix.enable = true;
  general.hostname = "DPigeon-RasPI";

  # --- Build-specific ---
  system.stateVersion = "24.05";
  # system.copySystemConfiguration = true;

}
