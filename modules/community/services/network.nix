{
  flake.aspects.network-salt.nixos =
    { config, lib, ... }:
    {
      environment.etc."NetworkManager/system-connections/HomeWifi.nmconnection".source = (
        lib.mkForce config.sops.templates."HomeWifi-Salt".path
      );

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

  flake.aspects.network-pepper.nixos =
    { config, lib, ... }:
    {
      environment.etc."NetworkManager/system-connections/HomeWifi.nmconnection".source = (
        lib.mkForce config.sops.templates."HomeWifi-Pepper".path
      );

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
        insertNameservers = [
          "1.1.1.1"
          "1.0.0.1"
        ];
      };
    };
}
