local servers = {
  lua_ls = {
    settings = {
      Lua = {
        telemetry = { enable = false },
      },
    },
  },
  ocamllsp = {},
  gleam = {},
  nixd = {},
  clangd = {},
  nil_ls = {},
  elixirls = {
    cmd = { "elixir-ls" },
    elixirLS = {},
  },
}


local function lsp_setup()
  --#region Auto-format on save
  local autoformat_group = vim.api.nvim_create_augroup("lsp-autoformat", { clear = true })
  vim.api.nvim_create_autocmd("LspAttach", {
    group = autoformat_group,
    desc = "autoformat",
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      if not client then return end

      if client:supports_method "textDocument/formatting" then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = autoformat_group,
          desc = "formatter",
          buffer = args.buf,
          callback = function() vim.lsp.buf.format { bufnr = args.buf, id = client.id } end,
        })
      end
    end,
  })
  --#endregion

  --#region Server setup
  for server, config in pairs(servers) do
    config.capablilities = require("blink.cmp").get_lsp_capabilities(config.capablilities)
    require("lspconfig")[server].setup(config)
  end
  --#endregion

  --#region Custom keybinds
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-keybinds", { clear = true }),
    desc = "Create_keybinds",
    callback = function(args)
      local function map(keys, callback, desc, mode)
        mode = mode or "n"
        vim.keymap.set(mode, keys, callback, { buffer = args.buf, desc = "LSP: " .. desc })
      end

      map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
      map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
      map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
      map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
      map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
      map(
        "<leader>ws",
        require("telescope.builtin").lsp_dynamic_workspace_symbols,
        "[W]orkspace [S]ymbols"
      )
      map("<leader>lf", vim.lsp.buf.format, "[L]sp [F]ormat")
      map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
      map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
      map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    end,
  })

  --#endregion
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "folke/lazydev.nvim", "j-hui/fidget.nvim", "saghen/blink.cmp" },
    config = lsp_setup,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } },
  },
  { "j-hui/fidget.nvim", opts = {} },
}
