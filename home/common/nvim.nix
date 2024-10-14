{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    neovim-customization.enable = lib.mkEnableOption "my nvim config";
  };

  config =
    let
      opts = config.neovim-customization;
    in
    lib.mkIf opts.enable {
      programs.neovim = {
        enable = true;
        plugins = with pkgs.vimPlugins; [
          lazy-nvim
        ];
        vimAlias = true;
        vimdiffAlias = true;
        withNodeJs = true;
        package = pkgs.neovim;
      };
      home.packages = with pkgs; [
        xclip
        ripgrep

        clang

        nodePackages.prettier

        lua-language-server
        lua53Packages.luacheck
        stylua

      ];

      xdg.configFile.nvim = {
        enable = true;
        source = ./configs/nvim;
        recursive = true;
      };
    };
}
