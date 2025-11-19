vim.g.mapleader = " "
vim.o.switchbuf = "usetab"
vim.o.breakindentopt = "list:-1"
vim.o.colorcolumn = "+1"
vim.o.relativenumber = true
vim.o.winborder = "rounded"
vim.o.cursorlineopt = "screenline,number"
vim.o.fillchars = "eob:ø,fold:·"
vim.o.list = true
vim.opt.listchars = { tab = "»\\ ", trail = "·", nbsp = "␣" }
vim.o.wrap = true
vim.o.foldlevel = 10
vim.o.foldmethod = "indent"
vim.o.foldnestmax = 10
vim.o.foldtext = ""
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.spelloptions = "camel"
vim.o.tabstop = 2
vim.o.iskeyword = "@,48-57,_,192-255,-"
vim.o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]
vim.o.complete = ".,w,b,kspell"
vim.o.completeopt = "menuone,noselect,fuzzy,nosort"
vim.o.scrolloff = 10
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.indentexpr = "nvim_treesitter#indentexpr()"

--- ShaDa(Shared data) file size limitations
-- '100: 100 files with marks saved
-- <50: 50 lines per register
-- s10: 10kB of size
-- :1000: 1000 lines in CLI history
-- /100: 100 lines in search history
-- @100: 100 lines in input-line history (input boxes, like telescope's?)
-- h keep the hlshearch when loading shada.
vim.o.shada = "'100,<50,s10,:1000,/100,@100,h"

_G.Config.new_autocmd("FileType", nil, function()
  vim.cmd("setlocal formatoptions-=c formatoptions-=o")
end, "Proper 'formatoptions'")

local diagnostic_opts = {
  signs = {
    priority = 9999,
    severity = {
      min = vim.diagnostic.severity.WARN,
      max = vim.diagnostic.severity.ERROR,
    },
  },

  underline = { severity = {
    min = vim.diagnostic.severity.HINT,
    max = vim.diagnostic.severity.ERROR,
  } },

  virtual_lines = false,
  virtual_text = { current_line = true },

  update_in_insert = false,
}

vim.api.nvim_create_autocmd({ "FileType" }, {
  callback = function()
    if vim.list_contains(require("nvim-treesitter").get_installed(), vim.bo.ft)
    then
      vim.wo.foldmethod = "expr"
    else
      vim.wo.foldmethod = "syntax"
    end
  end,
})

MiniDeps.later(function()
  vim.diagnostic.config(diagnostic_opts)
end)
