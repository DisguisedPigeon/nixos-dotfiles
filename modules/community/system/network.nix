{
  flake.aspects.nm.nixos =
    { config, lib, ... }:
    let
      cfg = config.custom.network;
    in
    {
      # This allows reusing this module for all hosts used in my home wifi
      options.custom.network = {
        install_home_wifi = lib.mkEnableOption "install the home wifi connection";

        ip = lib.mkOption { type = lib.types.str; };
        interface = lib.mkOption { type = lib.types.str; };
      };

      config =
        lib.mkMerge [
          # Static config
          {
            networking.networkmanager = {
              enable = true;
              wifi.powersave = true;
            };
          }
          # Host-dependent config
          (lib.mkIf cfg.install_home_wifi {
            networking.hosts."192.168.1.1" = [ "gateway" ];

            environment.etc.nm-file = {
              source = config.sops.templates."HomeWifi".path;
              target = "NetworkManager/system-connections/HomeWifi.nmconnection";
            };

            sops.templates."HomeWifi" = {
              content = ''
                [connection]
                id=${config.sops.placeholder.home-ssid}
                uuid=75e9a233-5f30-4c4b-a410-dc8ff601aeba
                type=wifi
                interface-name=${cfg.interface}
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
                address1=${cfg.ip}

                route1=192.168.1.0/24,0.0.0.0,600
                route2=192.168.1.0/24,0.0.0.0,600
                route3=0.0.0.0/0,192.168.1.1,600

                dns=1.1.1.1;1.0.0.1

                [ipv6]
                addr-gen-mode=default
                method=auto
              '';
            };
          })
        ];
    };
}
