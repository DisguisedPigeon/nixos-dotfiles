return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter-context" },
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = {
        "vim",
        "vimdoc",
        "lua",
        "luadoc",
        "query",
        "diff",
        "bash",
        "c",
        "markdown",
        "markdown_inline",
        "html",
        "gleam",
      },
      auto_install = true,
      highlight = {
        enable = {},
      },
      indent = { enable = true },
    },
    config = function()
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end,
  },
  { "nvim-treesitter/nvim-treesitter-context", opts = { enable = true } },
}
