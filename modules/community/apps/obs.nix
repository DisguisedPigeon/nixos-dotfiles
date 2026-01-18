{
  flake.aspects.obs.nixos =
    { pkgs, ... }:
    {
      programs.obs-studio.enable = true;

      environment.systemPackages = [ pkgs.v4l-utils ];

      programs.obs-studio.enableVirtualCamera = true;
    };
}
