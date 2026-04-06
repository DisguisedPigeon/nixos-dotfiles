local lib = require("lib")

--#region globals
vim.g.mapleader = " "
vim.g.maplocalleader = " "
--#endregion

--#region options
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes:1"
--#endregion

--#region plugins
vim.pack.add({
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/rose-pine/nvim",
	"https://github.com/echasnovski/mini.nvim",
})
--#endregion

--#region lsp
local lsp_files = lib.list_from_dir(vim.fn.stdpath("config") .. "/lsp")

vim.iter(lsp_files):map(function(file)
	local server_name = file:sub(1, -5)
	vim.lsp.enable(server_name)
end)
--#endregion

--#region treesitter
local parser_files = lib.list_from_dir(vim.fn.stdpath("config") .. "/parser")

vim.iter(parser_files):map(function(file)
	local parser_name = file:sub(1, -4) -- remove the extension

	-- autocmd to enable treesitter features on enter.
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
--#endregion

-- lua/mini-plugin
require("mini-plugin").setup()

--#region Oil
local oil = require("oil")
oil.setup({})

lib.nmap("-", require("oil").open , "Open parent directory")

vim.opt.shortmess:append("I")
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 and vim.api.nvim_buf_get_name(0) == "" then
      vim.schedule( oil.open)
    end
  end,
})
--#endregion

--#region Colorscheme
require("rose-pine").setup({ styles = { transparency = true } })
vim.cmd.colorscheme("rose-pine")
--#endregion

-- vim: ts=2 sts=2 sw=2 et
