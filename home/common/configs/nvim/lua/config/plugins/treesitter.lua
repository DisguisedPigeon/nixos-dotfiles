return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "OXY2DEV/markview.nvim" },
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "gleam",
        "html",
        "lua",
        "nix",
        "python",
        "markdown_inline",
        "markdown",
      }, { summary = true })

      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function() require("nvim-treesitter.parsers").lua.install_info.generate = true end,
      })

      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = { multiwindow = true },
  },
}
