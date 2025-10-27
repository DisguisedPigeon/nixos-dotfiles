{
  flake-file.inputs.zen.url = "github:0xc000022070/zen-browser-flake";

  flake.modules.homeManager.dpigeon-salt-extra-apps =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        discord-canary
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
