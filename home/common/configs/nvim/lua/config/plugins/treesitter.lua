return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "OXY2DEV/markview.nvim" },
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter').install({
        'gleam',
        'nix',
        'python',
        'go',
        'elixir',
        'erlang',
        'markdown_inline',
        'markdown',
      }, { force = true, max_jobs = 10, summary = true }):wait(1000)

      vim.api.nvim_create_autocmd('User', {
        pattern = 'TSUpdate',
        callback = function()
          require('nvim-treesitter.parsers').lua.install_info.generate = true
        end
      })

      vim.treesitter.start()

      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = { multiwindow = true }
  }
}
