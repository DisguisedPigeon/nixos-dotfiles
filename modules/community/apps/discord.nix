{
  flake.aspects.discord.homeManager =
    { pkgs, ... }:
    {
      xdg.configFile."discord/settings.json".text = ''{"SKIP_HOST_UPDATE": true}'';
      home.packages = with pkgs; [ discord ];
    };

}
