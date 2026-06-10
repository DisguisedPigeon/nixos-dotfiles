{
  flake.aspects.ssh-server.nixos = {

    services = {
      # fail2ban.enable = true;

      openssh = {
        enable = true;
        ports = [ 6922 ];
        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
          AllowUsers = [ "dpigeon@salt" "root@salt" ];
        };
      };

      endlessh = {
        enable = true;
        port = 22;
        openFirewall = true;
      };
    };
  };
}
