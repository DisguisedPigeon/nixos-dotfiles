{
  flake.aspects.dpigeon.nixos =
    { config, ... }:
    {
      users.users.dpigeon = {
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets.user-password.path;
        extraGroups = [
          "dpigeon"
          "wheel"
          "podman"
          "user"
          "trusted"
        ];
      };
    };

}
