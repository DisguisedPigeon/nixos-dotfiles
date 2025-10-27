{ inputs, ... }:
{
  flake.modules.nixos.dpigeon =
    { pkgs, lib, ... }:
    {
      users.users.dpigeon = {
        shell = pkgs.zsh;
        initialPassword = "ligma";
        isNormalUser = true;
        extraGroups = [
          "dpigeon"
          "user"
        ];
      };
    };

  flake.modules.homeManager.dpigeon-salt = {
    imports = with inputs.self.modules.homeManager; [
      ui
      stylix
      hyprland
      kde-connect
      networkmanager
      niri
      starship
      rofi
      waybar
      wezterm
      zen
      thunderbird
    ];
    home.username = "dpigeon";
    home.homeDirectory = "/home/dpigeon";
    home.stateVersion = "25.05";
  };
}
