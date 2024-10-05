{
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../modules/nix-setup.nix
  ];
  # --- Custom modules config ---
  dev.enable = true;
  dualboot.enable = true;
  graphics.enable = true;
  hardware-optimizations = { enable = true; device-data.name = "asus-zephyrus-ga502"; };
  stylix.enable = true;
  # --- Other config ---

  system.stateVersion = "24.05";
  # system.copySystemConfiguration = true;

  programs.light.enable = true;

  environment = {
    systempackages = [
      pkgs.caffeine-ng
      pkgs.ntfs3g
      pkgs.home-manager
    ];
  };

  users.groups.configEditor.gid = 69420;

  users.users = {
    dpigeon = {
      shell = pkgs.zsh;
      initialPassword = "ligma";
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "configEditor"
        "docker"
      ];
    };
    test = {
      shell = pkgs.zsh;
      initialPassword = "ligma";
      isNormalUser = true;
      extraGroups = [ "configEditor" ];
    };
  };

}
