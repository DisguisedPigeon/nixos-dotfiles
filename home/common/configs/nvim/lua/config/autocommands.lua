-- Autofornat on save
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

-- keybinds
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-keybinds", { clear = true }),
  desc = "Create_keybinds",
  callback = function(args)
    local function map(keys, callback, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, callback, { buffer = args.buf, desc = "LSP: " .. desc })
    end

    map("<leader>lgr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    map("<leader>lgI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
    map("<leader>lgd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
    map("<leader>lgD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

    map("<leader>lds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    map(
      "<leader>lws",
      require("telescope.builtin").lsp_dynamic_workspace_symbols,
      "[W]orkspace [S]ymbols"
    )
    map("<leader>lf", function() vim.lsp.buf.format { async = true } end, "[L]sp [F]ormat")
    map("<leader>lrn", vim.lsp.buf.rename, "[L]sp [R]e[N]ame")
    map("<leader>lc", vim.lsp.buf.code_action, "[C]ode Actions", { "n", "x" })
    map("K", vim.lsp.buf.hover, "[K]over")
    map("<C-k>", vim.lsp.buf.signature_help, "[C]ignature[K]elp")
  end,
})

-- highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on text yank",
  group = vim.api.nvim_create_augroup("DPigeon-Yank-Highlight", { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

-- Source project config
vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Source project config",
  group = vim.api.nvim_create_augroup("DPigeon-Source-Project", { clear = true }),
  callback = function()
    pcall(vim.cmd.source, vim.uv.exepath() .. "nvim/init.lua")
  end
})
