{
  flake.aspects.hosts.nixos = {
    networking.hosts = {
      "192.168.1.1" = [ "gateway" ];
    };
  };
}
