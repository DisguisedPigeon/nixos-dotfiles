{ lib, config, ... }:
{
  options = {
    general-bundle = lib.mkEnableOption "General linux services";
    ui-bundle = lib.mkEnableOption "Desktop oriented services";
    server-bundle = lib.mkEnableOption "Server oriented services";
  };

  config = lib.mkMerge [

    (lib.mkIf config.general-bundle {
      programs.zsh.enable = true;
      virtualisation.podman.enable = true;
    })

    (lib.mkIf config.server-bundle {
      services.openssh.enable = true;
    })

    (lib.mkIf config.ui-bundle {
      services = {
        flatpak.enable = true;
        libinput.enable = true;
        pipewire = {
          enable = true;
          pulse.enable = true;
          alsa.enable = true;
        };
        displayManager.sddm.enable = true;
      };
      boot.loader.limine.enable = true;
      stylix.enable = true;
      networking = {
        networkmanager.enable = true;
        useDHCP = true;
      };
    })
  ];
}
