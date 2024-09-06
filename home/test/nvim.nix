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
      harpoon
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
      nvim-treesitter
      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects
      vim-surround
      nvim-dap
      nvim-dap-ui
      cmp-nvim-lsp
      tokyonight-nvim
      rose-pine
      catppuccin-nvim
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