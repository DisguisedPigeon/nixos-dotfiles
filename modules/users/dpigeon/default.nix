{
  flake.aspects.dpigeon.nixos =
    { config, ... }:
    {
      users.users.dpigeon = {
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets.user-password.path;
        extraGroups = [
          "wheel"
          "podman"
          "user"
          "trusted"
        ];
      };
    };
}
