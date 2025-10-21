{ inputs, ... }:
let
  flake.modules.nixos.ui = {
    imports = with inputs.self.modules.nixos; [
      pipewire
      sddm
      limine
      stylix
      networkmanager
    ];
    services = {
      libinput.enable = true;
      flatpak.enable = true;
    };
  };
in
{
  inherit flake;
}
