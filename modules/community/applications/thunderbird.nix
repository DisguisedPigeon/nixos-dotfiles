{
  flake.modules.homeManager.thunderbird = {
    programs.thunderbird.enable = true;
    programs.thunderbird.profiles.dpigeon.isDefault = true;
  };
}
