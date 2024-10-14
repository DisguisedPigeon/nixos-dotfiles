{ lib, config, ... }:
{
  import = [
    ./terminal.nix
  ];

  options = {
    zsh-customization.enable = lib.mkEnableOption "switches a few GNUtools for rust alternatives";
  };

  config =
    let
      opts = config.zsh-customization;
    in
    lib.mkIf opts.enable {
      programs.bat = {
        enable = true;
      };
      programs.eza = {
        enable = true;
      };
      programs.zoxide = {
        enable = true;
        options = [ "--cmd cd" ];
      };
      programs.fzf = {
        enable = true;
      };
      programs.ripgrep = {
        enable = true;
      };
      programs.zsh = {
        shellAliases = {
          cat = "bat";
        };
      };
    };
}
