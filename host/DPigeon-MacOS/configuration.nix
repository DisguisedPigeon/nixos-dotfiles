{ inputs, pkgs, ... }:
{
  imports = [
    inputs.hardware.nixosModules.asus-zephyrus-ga502
    ./hardware-configuration.nix
    ../modules
  ];

  # --- Build-specific ---
  system.stateVersion = "24.05";
}
