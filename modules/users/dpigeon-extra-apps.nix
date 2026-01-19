{
  flake.modules.homeManager.dpigeon-salt-extra-pkgs =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        gimp3
        obsidian
        tor
        transmission_4
        onionshare-gui
        vlc
        whatsapp-electron
      ];
    };
}
