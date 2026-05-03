{
  flake.aspects.forgejo = {
    nixos = {
      services.forgejo = {
        enable = true;
        database.type = "postgres";
      };
      users.users.forgejo.openssh.authorizedKeys.keyFiles = [ ../../../resources/forgejo.pub ];
    };
  };
}
