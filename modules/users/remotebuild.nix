{
  flake.modules.nixos.remotebuild = {
    users = {
      groups.remotebuild = { };

      users.remotebuild = {
        isSystemUser = true;
        group = "remotebuild";
        useDefaultShell = true;
        openssh.authorizedKeys.keyFiles = [ ../../resources/remotebuild.pub ];
      };
    };
    nix.settings.trusted-users = [ "remotebuild" ];
  };
}
