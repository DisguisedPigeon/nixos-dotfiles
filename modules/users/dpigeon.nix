{ inputs, ... }:
{
  flake.homeConfigurations.dpigeon-salt = {
    imports = with inputs.self.modules.homeManager; [
      home-manager
      ui-bundle
      kde-connect
      obs
      thunderbird
    ];
  };
}
