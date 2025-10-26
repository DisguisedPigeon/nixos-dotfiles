return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "OXY2DEV/markview.nvim" },
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup { install_dir = vim.fn.stdpath "data" .. "/site" }
      require("nvim-treesitter").install({
        "gleam",
        "lua",
        "nix",
        "markdown_inline",
        "markdown",
      }, { summary = true })

      vim.o.foldmethod = "expr"
      vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

      vim.o.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = { multiwindow = true },
  },
}
