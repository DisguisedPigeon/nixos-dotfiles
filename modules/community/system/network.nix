{
  flake.modules.nixos = {
    network-salt =
      { config, lib, ... }:
      {
        networking.networkmanager = {
          enable = true;
          wifi.powersave = true;
        };

        environment.etc."NetworkManager/system-connections/HomeWifi.nmconnection".source =
          lib.mkForce
            config.sops.templates."HomeWifi-Salt".path;

        sops.templates."HomeWifi-Salt" = {
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
            method=manual
            gateway=192.168.1.1
            address1=192.168.1.4/24

            route1=192.168.1.0/24,0.0.0.0,600
            route2=192.168.1.0/24,0.0.0.0,600
            route3=0.0.0.0/0,192.168.1.1,600

            dns=1.1.1.1;1.0.0.1

            [ipv6]
            addr-gen-mode=default
            method=auto
          '';
          owner = "root";
          mode = "0600";
        };

      };

    network-pepper =
      { config, lib, ... }:
      {
        networking.networkmanager.enable = true;

        environment.etc."NetworkManager/system-connections/HomeWifi.nmconnection".source =
          lib.mkForce
            config.sops.templates."HomeWifi-Pepper".path;

        sops.templates."HomeWifi-Pepper" = {
          content = ''
            [connection]
            id=${config.sops.placeholder.home-ssid}
            uuid=75e9a233-5f30-4c4b-a410-dc8ff601aeba
            type=wifi
            interface-name=wlan0
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
            method=manual
            gateway=192.168.1.1
            address1=192.168.1.3/24

            route1=192.168.1.0/24,0.0.0.0,600
            route2=192.168.1.0/24,0.0.0.0,600
            route3=0.0.0.0/0,192.168.1.1,600

            dns=1.1.1.1;1.0.0.1

            [ipv6]
            addr-gen-mode=default
            method=auto
          '';
          owner = "root";
          mode = "0600";
        };

      };
  };
}
