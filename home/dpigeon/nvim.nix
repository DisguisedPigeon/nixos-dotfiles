{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    plugins = with pkgs.vimPlugins; [
      nvim-web-devicons
      harpoon2
      todo-comments-nvim
      undotree
      luasnip
      vim-fugitive
      fidget-nvim
      oil-nvim
      glow-nvim
      gitsigns-nvim
      nvim-lspconfig
      nvim-cmp
      lualine-nvim
      comment-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      telescope-ui-select-nvim
      nvim-treesitter
      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects
      vim-surround
      nvim-dap
      nvim-dap-ui
      cmp-nvim-lsp
      tokyonight-nvim
      none-ls-nvim
    ];
  };

  home.packages = with pkgs; [
    xclip
    ripgrep

    nodePackages.prettier
    statix
    deadnix
    nil
    nixfmt-rfc-style

    lua-language-server
    lua53Packages.luacheck
    stylua

  ];

  xdg.configFile.nvim = {
    enable = true;
    source = ./configs/nvim;
    recursive = true;
  };
}
