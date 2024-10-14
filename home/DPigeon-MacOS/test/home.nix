{
  pkgs,
  ...
}:
{
  imports = [
    ../../common
  ];

  zsh-customization.hostname = "DPigeon-MacOS";

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
