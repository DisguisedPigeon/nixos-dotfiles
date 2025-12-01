{
  flake.modules.homeManager.nvim =
    { pkgs, ... }:
    {
      programs.neovim.enable = true;

      home.packages = with pkgs; [
        ripgrep # file grepping
        fd # find but easier
      ];

      programs.neovim = {
        plugins = [ pkgs.vimPlugins.mini-deps ];
        vimAlias = true;
        vimdiffAlias = true;
        withNodeJs = true;
      };

      xdg.configFile.nvim = {
        enable = true;
        source = ../../../resources/config/nvim;
        recursive = true;
      };
    };
}
