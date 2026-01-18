{
  flake.aspects.zoxide.homeManager = {
    programs.zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };
  };
}
