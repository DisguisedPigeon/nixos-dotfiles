vim.o.number = true
vim.o.relativenumber = true

vim.o.signcolumn = "yes:1"
vim.o.colorcolumn = "80"

vim.o.foldlevel = 99

vim.o.smartcase = true
vim.o.ignorecase = true

vim.o.scrolloff = 10

vim.opt.formatoptions:remove("o")

function FoldText()
  return vim.fn.getline(vim.v.foldstart) -- First line of the fold
    .. " ["
    .. vim.v.foldend - vim.v.foldstart + 1 -- Size of the fold
    .. "]"
end

vim.o.foldtext = "v:lua.FoldText()"
vim.opt.fillchars:append({ fold = " " })
vim.api.nvim_set_hl(0, "Folded", { link = "WinBar" })
