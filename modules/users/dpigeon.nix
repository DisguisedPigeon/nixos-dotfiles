{ inputs, ... }:
{
  flake.modules.nixos.dpigeon =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      imports = [ inputs.self.modules.nixos.sops ];

      users = {
        mutableUsers = lib.mkDefault false;
        users.dpigeon = {
          shell = pkgs.zsh;
          hashedPasswordFile = config.sops.secrets.user-password.path;
          isNormalUser = true;
          extraGroups = [
            "dpigeon"
            "user"
          ];
        };
      };
    };

  flake.modules.homeManager.dpigeon-salt = {
    imports = with inputs.self.modules.homeManager; [
      ui
      bitwarden
      stylix
      kde-connect
      sops
      niri
      mango
      starship
      rofi
      wezterm
      zen
      thunderbird
      bat
      eza
      fzf
      zoxide
      dpigeon-salt-extra-pkgs
    ];

    home.sessionVariables.host = "salt";
    home.sessionVariables.EDITOR = "nvim";

    home.username = "dpigeon";
    home.homeDirectory = "/home/dpigeon";
    home.stateVersion = "25.05";
  };
}
