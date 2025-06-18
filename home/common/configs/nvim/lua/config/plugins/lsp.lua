local servers = {
  lua_ls = {
    settings = {
      Lua = {
        telemetry = { enable = false },
      },
    },
  },

  gleam = {},

  ruff = {},

  elixirls = {
    cmd = { "elixir-ls" },
    elixirLS = {},
  },

  erlangls = {},

  rust_analyzer = { settings = { ["rust-analyzer"] = { diagnostics = { enable = false } } } },

  clangd = {},

  nixd = {},
  nil_ls = {},

  html = {},
  cssls = {},

  tailwindcss = {
    workspace_required = false,
    root_marker = "gleam.toml",
    filetypes = { "gleam" },
    settings = {
      tailwindCSS = {
        experimental = { configFile = "theme.css" },
        classFunctions = {
          "class\\(\\s*['\"]([^'\"]*)['\"]\\s*\\)",
          "#?\\(\\s*['\"]([^'\"]*)['\"]\\s*,\\s*[^\\)]*\\)",
        },
        includeLanguages = { gleam = "javascript" },
      },
    },
  },

  ltex_plus = { settings = { ltex = { language = "es-ES" } } },
}

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "folke/lazydev.nvim", "j-hui/fidget.nvim", "saghen/blink.cmp" },
    config = function()
      for server, config in pairs(servers) do
        vim.lsp.config(
          server,
          vim.tbl_deep_extend(function(_, prev, value)
            if type(prev) == "table" and vim.tbl_contains(prev, 1) == false then
              return vim.list_extend(prev, value)
            else
              return value
            end
          end, config, vim.lsp.config[server])
        )
        vim.lsp.config(server, config)
        if vim.fn.executable(vim.lsp.config[server].cmd[1]) == 1 then vim.lsp.enable(server) end
      end
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
