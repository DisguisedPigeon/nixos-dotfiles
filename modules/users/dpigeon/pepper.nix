{
  flake.aspects.dpigeon-pepper.nixos = {
    users.users = {
      dpigeon.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKG5N/sJAGpJNlL3WRvNvRFMVMS/y+IChr8rTSnxzI9i root@salt"

      ];
      git.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF2usCLJudA5GvpM9UdDZJoxh+JUBeHcpWTVvyqHdTGn dpigeon@salt"
      ];
    };
  };
}
