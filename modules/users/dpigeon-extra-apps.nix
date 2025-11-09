{
  flake-file.inputs.zen = {
    url = "github:0xc000022070/zen-browser-flake";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.homeManager.dpigeon-salt-extra-pkgs =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        discord-canary
        spotube
        yt-dlp
        gimp3
        obsidian
        pavucontrol
        tor
        transmission_4
        onionshare-gui
        typora
        vlc
        whatsapp-electron

      ];
    };
}
