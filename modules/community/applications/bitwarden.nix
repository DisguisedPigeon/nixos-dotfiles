let
  flake.modules.homeManager.bitwarden =
    { config, ... }:
    {
      sops.templates."rbw-config.json" = {
        content = ''
          {
            "email": "${config.sops.placeholder.bitwarden-mail}",
            "sso_id": null,
            "base_url": "bitwarden.eu",
            "identity_url": null,
            "ui_url": null,
            "notifications_url": null,
            "lock_timeout": 3600,
            "sync_interval": 3600,
            "pinentry": "pinentry",
            "client_cert_path": null
          }
        '';
        mode = "0440";
        path = "${config.xdg.configHome}/rbw/config.json";
      };
    };
in
{
  inherit flake;
}
