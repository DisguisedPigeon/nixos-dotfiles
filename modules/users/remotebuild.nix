{
  flake.modules.nixos.remote-build =
    { lib, ... }:
    {
      users.users.remotebuild = {
        isSystemUser = lib.mkDefault true;
        group = "remotebuild";
        useDefaultShell = lib.mkDefault true;
        openssh.authorizedKeys.keyFiles = [ ../../resources/remotebuild.pub ];
      };

      users.groups.remotebuild = lib.mkDefault { };

      nix.settings.trusted-users = lib.mkDefault [ "remotebuild" ];
    };
}
