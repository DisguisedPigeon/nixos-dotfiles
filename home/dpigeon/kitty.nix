{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [ maple-mono-NF ];
  programs.kitty = {
    enable = true;
    theme = "Tokyo Night Storm";
    font.name = "Maple Mono NF";
  };
}
