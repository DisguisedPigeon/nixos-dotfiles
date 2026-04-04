{
  flake.aspects.gitea = {
    nixos = {
      services.gitea = {
        enable = true;
        database.type = "postgres";
      };
      users.users.gitea.openssh.authorizedKeys.keyFiles = [ ../../../resources/gitea.pub ];
    };
  };
}
