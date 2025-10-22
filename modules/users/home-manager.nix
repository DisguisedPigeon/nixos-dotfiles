{
  flake.modules.homeManager.home-manager = {
    systemd.user.startServices = "sd-switch";
    programs.home-manager.enable = true;
  };
}
