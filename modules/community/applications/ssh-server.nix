{ ... }:
let
  flake.modules.nixos.ssh-server = {
    services = {
      openssh = {
        enable = true;
        ports = [ 6922 ];
        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
          PermitRootLogin = "no";
          AllowUsers = [ "dpigeon" ];
        };
      };

      fail2ban.enable = true;
      services.endlessh = {
        enable = true;
        port = 22;
        openFirewall = true;
      };
    };
  };
in
{
  inherit flake;
}
