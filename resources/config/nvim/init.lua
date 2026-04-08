vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lib = require("lib")

vim.keymap.set(
  "t",
  "<esc><esc>",
  "<C-\\><C-n>",
  { desc = "Quick normal mode from term mode" }
)
vim.keymap.set(
  "i",
  "<C- >",
  "<C-x><C-o>",
  { desc = "Easier omnifunc completion access (~lsp completion)" }
)

lib.nmap("<C-d>", "<C-d>zz", "Scroll down half screen, center")
lib.nmap("<C-u>", "<C-u>zz", "Scroll up half screen, center")

lib.nmap("<leader>tt", function()
  vim.cmd("tabnew")
  vim.cmd("term")
end, "open term in new tab")

lib.nmap("<C-u>", "<C-u>zz", "Scroll up half screen, center")

vim.cmd("packadd nohlsearch")
vim.cmd("packadd nvim.tohtml")
vim.cmd("packadd nvim.undotree")
vim.cmd("packadd nvim.difftool")

local spell = require("nvim.spellfile")

spell.get("gl")
spell.get("es")
spell.get("en")

vim.pack.add({
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/rose-pine/nvim",
  "https://github.com/echasnovski/mini.nvim",
})

local lsp_files = lib.list_from_dir(vim.fn.stdpath("config") .. "/lsp")

vim.iter(lsp_files):map(function(file)
  local server_name = file:sub(1, -5)
  vim.lsp.enable(server_name)
end)

local parser_files = lib.list_from_dir(vim.fn.stdpath("config") .. "/parser")

vim.iter(parser_files):map(function(file)
  local parser_name = file:sub(1, -4) -- remove the extension

  vim.api.nvim_create_autocmd("FileType", {
    -- HACK: this assumes the parser name is the same as the filetype.
    -- I think this works for every language I have installed, but it may not be universal.
    pattern = { parser_name },
    callback = function()
      vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo[0][0].foldmethod = "expr"

      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

      vim.treesitter.start()
    end,
  })
end)

local oil = require("oil")
oil.setup({})

lib.nmap("-", require("oil").open, "Open parent directory")

vim.opt.shortmess:append("I")
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 and vim.api.nvim_buf_get_name(0) == "" then
      vim.schedule(oil.open)
    end
  end,
})

require("rose-pine").setup({ styles = { transparency = true } })
vim.cmd.colorscheme("rose-pine")

-- vim: ts=2 sts=2 sw=2 et
