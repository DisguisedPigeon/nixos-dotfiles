vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("vim._core.ui2").enable({})

-- Enable some included plugins
vim.cmd("packadd nvim.tohtml")
vim.cmd("packadd nvim.undotree")
vim.cmd("packadd nvim.difftool")

vim.o.ut = 2000
vim.cmd("packadd nohlsearch")

-- Set colorscheme
require("rose-pine").setup({ styles = { transparency = true } })
vim.cmd.colorscheme("rose-pine")

-- vim: ts=2 sts=2 sw=2 et
