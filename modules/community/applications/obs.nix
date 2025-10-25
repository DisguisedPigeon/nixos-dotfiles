{
  flake.modules.nixos.obs =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.v4l-utils ];
      programs.obs-studio.enable = true;
      programs.obs-studio.enableVirtualCamera = true;
    };
}
