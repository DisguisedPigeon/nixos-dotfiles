{ inputs, ... }:
{
  flake.modules.nixos.dpigeon =
    { pkgs, ... }:
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
      wezterm
      zen
      thunderbird
      dpigeon-salt-extra-apps
      bat
      eza
      fzf
      zoxide
    ];

    home.sessionVariables.host = "salt";
    home.sessionVariables.EDITOR = "nvim";

    home.username = "dpigeon";
    home.homeDirectory = "/home/dpigeon";
    home.stateVersion = "25.05";
  };
}
