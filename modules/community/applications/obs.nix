{
  flake.modules.nixos.obs =
    { pkgs, ... }:
    {
      programs.obs-studio.enable = true;

      environment.systemPackages = [ pkgs.v4l-utils ];

      programs.obs-studio.enableVirtualCamera = true;
    };
}
