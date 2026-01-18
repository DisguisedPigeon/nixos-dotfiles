{
  flake.aspects.thunderbird = {
    homeManager = {
      programs.thunderbird = {
        enable = true;
        profiles.dpigeon.isDefault = true;
      };
    };
  };
}
