require "config.lazy"
require "config.opts"
require "config.keybinds"

vim.lsp.enable("clangd")
vim.lsp.enable("elixirls")
vim.lsp.enable("gleam")
vim.lsp.enable("html")
vim.lsp.enable("ltex_plus")
vim.lsp.enable("lua_ls")
vim.lsp.enable("nil_ls")
vim.lsp.enable("nixd")
vim.lsp.enable("ocamllsp")
vim.lsp.enable("ruff")
vim.lsp.enable("rust_analyzer")

require "config.autocommands"
