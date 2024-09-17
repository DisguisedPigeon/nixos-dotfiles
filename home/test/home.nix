{
  outputs,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./zsh.nix
    ./starship.nix
		../common/home.nix
  ];

  home = {
    username = "test";
    homeDirectory = "/home/test";
    packages = with pkgs; [
      floorp
      youtube-music
    ];
  };
}
