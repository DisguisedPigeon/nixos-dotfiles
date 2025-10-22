{ inputs, ... }:
let
  flake.modules.nixos.salt =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        ui
        salt-hardware
        (import ./_users.nix {
          dpigeon = {
            shell = pkgs.zsh;
            initialPassword = "ligma";
            isNormalUser = true;
            extraGroups = [
              "dpigeon"
              "wheel"
              "user"
              "docker"
            ];
          };
        })
      ];
      loader.limine.extraEntries =
        if inputs.self.nixosConfigurations.salt.config.boot.loader.limine.enable then
          ''
            /Windows
                      protocol: efi
                      path: boot():/EFI/microsoft/boot/bootmgfw.efi
          ''
        else
          "";

      fileSystems."/mnt/disk2" = {
        device = "/dev/disk/by-uuid/92F44E63F44E49A5";
        fsType = "ntfs";
        options = [
          "noatime"
          "defaults"
          "user"
          "rw"
        ];
      };

      services.fstrim.enable = true;

      system.stateVersion = "24.05";
    };
in
{
  inherit flake;
}
