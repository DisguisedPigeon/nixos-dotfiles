{
  flake.aspects.docker.nixos =
    { pkgs, ... }:
    {
      virtualisation = {
        containers.enable = true;
        podman = {
          enable = true;
          defaultNetwork.settings.dns_enabled = true;
        };
        #docker = {
        #  enable = true;
        #  enableOnBoot = true;
        #};
      };
      environment.systemPackages = [ pkgs.podman-compose ];
    };
}
