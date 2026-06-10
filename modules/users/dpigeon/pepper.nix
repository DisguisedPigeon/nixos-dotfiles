{
  flake.aspects.dpigeon-pepper.nixos = {
    users.users = {
      dpigeon.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKQPmyLMFnYp0Wb1NFJ2vrmlJ4hmMlzQGIZis4jLhxO9 root@salt"
      ];
    };
  };
}
