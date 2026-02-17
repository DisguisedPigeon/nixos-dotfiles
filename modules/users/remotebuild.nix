{
  flake.modules.nixos.remote-build = {
    users.users.remotebuild = {
      isSystemUser = true;
      group = "remotebuild";
      useDefaultShell = true;
      openssh.authorizedKeys.keyFiles = [ ../../resources/remotebuild.pub ];
    };

    users.groups.remotebuild = { };

    nix.settings.trusted-users = [ "remotebuild" ];
  };
}
