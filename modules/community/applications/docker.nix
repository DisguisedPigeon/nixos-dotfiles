let
  flake.modules.nixos.docker =
    { pkgs, ... }:
    {
      virtualisation = {
        containers.enable = true;
        podman = {
          enable = true;
          dockerCompat = true;
          defaultNetwork.settings.dns_enabled = true;
        };
      };
      environment.systemPackages = [
        pkgs.podman-compose
      ];
    };
in
{
  inherit flake;
}
