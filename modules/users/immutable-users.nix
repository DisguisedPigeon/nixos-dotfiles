{
  flake.aspects.immutable-users.nixos =
    { lib, ... }:
    {
      users.mutableUsers = lib.mkDefault false;
    };
}
