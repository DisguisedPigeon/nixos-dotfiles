{
  flake.modules.homeManager.thunderbird = {
    programs.thunderbird = {
      enable = true;
      profiles.dpigeon = {
        isDefault = true;
      };
    };
  };
}
