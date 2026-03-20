{
  flake.aspects.gitea = {
    nixos = {
      programs.gitea = {
        enable = true;
        database.type = "postgres";
      };
    };
  };
}
