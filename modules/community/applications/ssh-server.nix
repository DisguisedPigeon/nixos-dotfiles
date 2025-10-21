{ ... }:
let
  flake.modules.nixos.ssh = {
    services = {
      services.endlessh = {
        enable = true;
        port = 22;
        openFirewall = true;
      };

      fail2ban.enable = true;
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
    };
  };
in
{
  inherit flake;
}
