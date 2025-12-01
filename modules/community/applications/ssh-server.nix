let
  flake.modules.nixos.ssh-server = {
    services.openssh.enable = true;
    services.fail2ban.enable = true;
    services.endlessh.enable = true;

    services.openssh = {
      ports = [ 6922 ];
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        AllowUsers = [ "dpigeon" ];
      };
    };

    services.endlessh = {
      port = 22;
      openFirewall = true;
    };
  };
in
{
  inherit flake;
}
