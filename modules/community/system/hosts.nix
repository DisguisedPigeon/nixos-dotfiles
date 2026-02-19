{
  flake.aspects.hosts.nixos = {
    networking.hosts = {
      "192.168.1.1" = [ "gateway" ];
      "192.168.1.2" = [ "a.magic.fourth.thing" ];
      "192.168.1.3" = [ "pepper" ];
      "192.168.1.4" = [ "salt" ];
    };
  };
}
