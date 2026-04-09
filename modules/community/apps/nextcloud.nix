{
  flake.aspects.nextcloud.nixos =
    { pkgs, config, ... }:
    let
      package = pkgs.nextcloud33;
    in
    {
      networking.firewall.allowedTCPPorts = [ 80 ];

      networking.firewall.trustedInterfaces = [ "tailscale0" ];

      services.nginx.virtualHosts."${config.services.nextcloud.hostName}" = {

        listen = [
          {
            addr = "0.0.0.0";
            port = 80;
          }
        ];

        extraConfig = ''
          allow 100.64.0.0/10;
          allow 127.0.0.1;
          allow ::1;
          deny all;
        '';
      };

      services.nextcloud = {
        enable = true;
        hostName = "nextcloud";
        datadir = "/mnt/nextcloud-data";

        package = package;

        database.createLocally = true;

        config = {
          adminpassFile = "/run/secrets/pepper-nextcloud";
          dbtype = "pgsql";
        };

        settings = {
          trusted_domains = [
            "localhost"
            "100.94.189.75"
          ];

        };

        extraAppsEnable = true;
        extraApps = {
          inherit (package.packages.apps) calendar tasks;
          news = pkgs.fetchNextcloudApp {
            appName = "news";
            appVersion = "28.1.0";
            url = "https://github.com/nextcloud/news/releases/download/28.1.0/news.tar.gz";
            hash = "sha256-KsHV3zN6kB391wIngALJLCgqcYLRw0PnU9JTDBM/lxo=";
            license = "agpl3Plus";
          };
        };

        settings.enabledPreviewProviders = [
          "OC\\Preview\\BMP"
          "OC\\Preview\\GIF"
          "OC\\Preview\\JPEG"
          "OC\\Preview\\Krita"
          "OC\\Preview\\MarkDown"
          "OC\\Preview\\MP3"
          "OC\\Preview\\OpenDocument"
          "OC\\Preview\\PNG"
          "OC\\Preview\\TXT"
          "OC\\Preview\\XBitmap"
          "OC\\Preview\\HEIC"
        ];
      };

      systemd.services.nextcloud-custom-config = {
        path = [ config.services.nextcloud.occ ];
        script = ''
          nextcloud-occ theming:config name "PigeonCloud"
          nextcloud-occ theming:config url "https://nextcloud";
          nextcloud-occ theming:config privacyUrl "https://pepper/privacy";
          nextcloud-occ theming:config color "#6400aa";
          nextcloud-occ theming:config logo ${../../../resources/logo.png}
        '';

        after = [ "nextcloud-setup.service" ];
        wantedBy = [ "multi-user.target" ];
      };
    };
}
