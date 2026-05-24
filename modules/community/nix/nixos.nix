{
  flake.aspects.nixos.nixos =
    { lib, ... }:
    {
      users.mutableUsers = lib.mkDefault false;
      programs.neovim = {
        enable = true;
        defaultEditor = true;
      };
    };
}
