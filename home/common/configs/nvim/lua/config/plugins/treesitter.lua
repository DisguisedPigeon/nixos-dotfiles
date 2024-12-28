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
        enable = true,
      },
      indent = { enable = true },
    },
    config = function()
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

      -- TODO : TEMPORAL, change when bug is fixed or module system thingy dissapears
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*.gleam",
        callback = function() vim.cmd "TSBufEnable highlight" end,
      })
    end,
  },
  { "nvim-treesitter/nvim-treesitter-context", opts = { enable = true } },
}
