{
  inputs,
  config,
  lib,
  ...
}:
{
  options = {
    hardware-optimizations.enable = lib.mkEnableOption "Enable hardware specific optimizations for this machine (as per nixos-hardware)";
    hardware-optimizations.device-data = {
      name = lib.mkDefault null;
      parts = lib.mkDefault [ ];
    };
  };

  config =
    let
      opts = config.hardware-optimizations;
    in
    lib.mkIf opts.enable {
      imports =
        [
          # If name is defined, add the device module
          (lib.mkIf opts.device-data.name != null inputs.hardware.nixosModules."${opts.device-data.name}")
        ]
        # If name is not defined, add the module for each part
        ++ lib.mkIf (opts.device-data.name == null) (
          lib.forEach opts.device-data.parts (str: inputs.hardware.nixosModules."${str}")
        );
    };
}
