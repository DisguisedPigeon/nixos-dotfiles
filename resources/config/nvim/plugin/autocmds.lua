local config_dir = require("nix-data").settings.config_directory
local lib = require("lib")

-- Enable configured language servers
local lsp_dir = config_dir .. "/lsp"

lib.iter_directory(lsp_dir):map(function(file)
  local server_name = file:sub(1, -5)
  vim.lsp.enable(server_name)
end)

-- Add custom keybinds
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    lib.nmap("grf", vim.lsp.buf.format, "Format file")
  end,
})

-- Enable configured treesitter parsers
local treesitter_parsers = lib
  .iter_directory(config_dir .. "/parser")
  :map(function(file)
    return file:sub(1, -4)
  end)
  :totable()

-- Enable treesitter on file enter if supported
vim.api.nvim_create_autocmd("FileType", {
  pattern = vim.list_extend(
    treesitter_parsers,
    { "c", "lua", "markdown", "markdown_inline", "query", "vim", "vimdoc" }
  ),
  callback = function()
    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo[0][0].foldmethod = "expr"

    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

    vim.treesitter.start()
  end,
})
