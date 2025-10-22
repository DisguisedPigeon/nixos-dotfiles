{ inputs, ... }:
{
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
