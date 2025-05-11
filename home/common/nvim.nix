{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    neovim-customization.enable = lib.mkEnableOption "my nvim config";
    neovim-customization.latex = lib.mkEnableOption "latex support";
  };

  config =
    let
      opts = config.neovim-customization;
      customization = lib.mkIf opts.enable {
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
          cmake

          nodePackages.prettier
          nodePackages.jsregexp
          fd

          lua-language-server
          lua53Packages.luacheck
          stylua

          tree-sitter-grammars.tree-sitter-latex
          tree-sitter

        ];

        xdg.configFile.nvim = {
          enable = true;
          source = ./configs/nvim;
          recursive = true;
        };
      };
      latex = lib.mkIf opts.latex {
        home.packages = with pkgs; [
          kdePackages.okular
          texliveMedium
        ];
      };
    in
    lib.recursiveUpdate customization latex;
}
