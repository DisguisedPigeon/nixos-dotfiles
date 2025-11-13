local servers = {
  lua_ls = { settings = { Lua = { telemetry = { enable = false } } } },

  gleam = {},

  ocamllsp = {},

  ruff = {},

  elixirls = { cmd = { "elixir-ls" }, elixirLS = {} },

  elp = {},

  rust_analyzer = { settings = { ["rust-analyzer"] = { diagnostics = { enable = false } } } },

  clangd = {},

  nixd = {},

  nil_ls = {},

  html = {},
  cssls = {},

  texlab = {
    build = {
      executable = "tectonic",
      args = {
        "-X",
        "compile",
        "%f",
        "--outdir",
        "_build",
        "--synctex",
        "--keep-logs",
        "--keep-intermediates",
      },
      forwardSearchAfter = false,
      auxdirectory = "_build",
      onSave = true,
      pdfDirectory = "_build",
    },
    forwardSearch = { executable = "okular", args = "--unique --noraise _build/%p#src:%l%f" },
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "folke/lazydev.nvim", "j-hui/fidget.nvim", "saghen/blink.cmp" },
    config = function()
      for server, config in pairs(servers) do
        vim.lsp.config(server, vim.tbl_deep_extend("keep", config, vim.lsp.config[server]))
        vim.lsp.config(server, config)
        if vim.fn.executable(vim.lsp.config[server].cmd[1]) == 1 then vim.lsp.enable(server) end
      end
      vim.diagnostic.config { virtual_text = true }
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "j-hui/fidget.nvim",
    opts = {},
  },
}
