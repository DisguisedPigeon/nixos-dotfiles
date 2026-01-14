let
  flake.modules.nixos.ssh-server = {
    services = {
      openssh.enable = true;
      fail2ban.enable = true;
      endlessh.enable = true;

      openssh = {
        ports = [ 6922 ];
        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
          AllowUsers = [ "dpigeon" ];
        };
      };

      endlessh = {
        port = 22;
        openFirewall = true;
      };
    };
  };
in
{
  inherit flake;
}
