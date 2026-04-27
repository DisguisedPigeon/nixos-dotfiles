vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable some included plugins
vim.cmd("packadd nohlsearch")
vim.cmd("packadd nvim.tohtml")
vim.cmd("packadd nvim.undotree")
vim.cmd("packadd nvim.difftool")

-- Set colorscheme
require("rose-pine").setup({ styles = { transparency = true } })
vim.cmd.colorscheme("rose-pine")

-- vim: ts=2 sts=2 sw=2 et
