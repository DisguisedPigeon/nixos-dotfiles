{
  flake.aspects.network.nixos =
    {
      config,
      lib,
      ...
    }:
    {
      environment.etc."NetworkManager/system-connections/CasaWifi.nmconnection".source =
        lib.mkForce
          config.sops.templates."CasaWifi".path;

      sops.templates."CasaWifi" = {
        content = ''
          [connection]
          id=${config.sops.placeholder.home-ssid}
          uuid=75e9a233-5f30-4c4b-a410-dc8ff601aeba
          type=wifi
          interface-name=wlp3s0
          timestamp=1769464491
          autoconnect=true
          permissions=

          [wifi]
          mode=infrastructure
          ssid=${config.sops.placeholder.home-ssid}

          [wifi-security]
          auth-alg=open
          key-mgmt=wpa-psk
          psk=${config.sops.placeholder.home-pass}

          [ipv4]
          method=auto

          [ipv6]
          addr-gen-mode=default
          method=auto
        '';
        owner = "root";
        mode = "0600";
      };

      networking.networkmanager = {
        enable = true;
        wifi.powersave = true;
        insertNameservers = [
          "1.1.1.1"
          "1.0.0.1"
        ];
      };
    };
}
