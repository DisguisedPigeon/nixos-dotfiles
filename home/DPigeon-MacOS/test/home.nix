{
  pkgs,
  ...
}:
{
  imports = [
    ../../common
  ];

  zsh-customization.hostname = "DPigeon-MacOS";
  kitty-customization.enable = true;

  home = {
    username = "test";
    homeDirectory = "/home/test";
    packages = with pkgs; [
      floorp
      youtube-music
    ];
    starship.prefix = "[TEST](yellow) - ";
  };
}
