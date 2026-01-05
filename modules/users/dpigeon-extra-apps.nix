{
  flake-file.inputs.zen = {
    url = "github:0xc000022070/zen-browser-flake";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.homeManager.dpigeon-salt-extra-pkgs =
    { pkgs, ... }:
    {
      xdg.configFile."discord/settings.json" = {
        enable = true;
        text = ''
          {
            "SKIP_HOST_UPDATE": true
          }
        '';
      };
      home.packages = with pkgs; [
        discord
        spotube
        yt-dlp
        gimp3
        obsidian
        pavucontrol
        tor
        grim
        slurp
        transmission_4
        onionshare-gui
        vlc
        whatsapp-electron

      ];
    };
}
