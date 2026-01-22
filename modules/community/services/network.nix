{
  flake.aspects.network.nixos = {
    networking.networkmanager.enable = true;

    # This isn't working right now, IDK why
    # networking = {
    #   wireless = {
    #     enable = true;
    #     networks."ext:ssid_home".psk = "ext:psk_home";
    #     interfaces = [ "wlp3s0" ];
    #     secretsFile = "/run/secrets/net-secretsFile";
    #   };

    #   useDHCP = true;
    #   defaultGateway = "192.168.1.1";

    #   nameservers = [
    #     "1.1.1.1"
    #     "1.0.0.1"
    #   ];

    #   interfaces.wlp3s0 = {
    #     ipv4.addresses = [
    #       {
    #         address = "192.168.1.4";
    #         prefixLength = 24;
    #       }
    #     ];
    #   };
    # };
  };
}
