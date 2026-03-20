{
  flake.aspects.gitea = {
    nixos = {
      programs.git = {
        enable = true;
        config.gpg.format = "ssh";
      };
      programs.gitea = {
        enable = true;
        database.type = "postgres";
      };
    };
  };
}
