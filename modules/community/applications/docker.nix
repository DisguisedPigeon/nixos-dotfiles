{ inputs', ... }:
let
  flake.modules.nixos.docker = {
    virtualisation = {
      containers.enable = true;
      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };
    environment.systemPackages = [
      inputs'.nixpkgs.legacyPackages.podman-compose
    ];
  };
in
{
  inherit flake;
}
