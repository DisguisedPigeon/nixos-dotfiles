users: {
  users.users = builtins.mapAttrs (_name: value: value) users;
}
