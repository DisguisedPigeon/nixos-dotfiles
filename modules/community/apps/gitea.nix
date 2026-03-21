{
  flake.aspects.gitea = {
    nixos = {
      services.gitea = {
        enable = true;
        database.type = "postgres";
      };
    };
  };
}
