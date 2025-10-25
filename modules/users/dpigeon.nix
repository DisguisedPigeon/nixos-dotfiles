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
      obs
      thunderbird
    ];
    home.username = "dpigeon";
    home.homeDirectory = "/home/dpigeon";
    home.stateVersion = "25.05";
  };
}
