vim.g.mapleader = " "
vim.opt.switchbuf = "usetab"
vim.opt.breakindentopt = "list:-1"
vim.opt.colorcolumn = "+1"
vim.opt.relativenumber = true
vim.opt.winborder = "rounded"
vim.opt.cursorlineopt = "screenline,number"
vim.opt.fillchars = "eob:ø,fold:·"
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.foldlevel = 10
vim.opt.foldmethod = "indent"
vim.opt.foldnestmax = 10
vim.opt.foldtext = ""
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.spelloptions = "camel"
vim.opt.spl = { "en", "es", "gl" }
vim.opt.tabstop = 2
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"
vim.opt.undofile = true
vim.opt.iskeyword = "@,48-57,_,192-255,-"
vim.opt.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]
vim.opt.complete = ".,w,b,kspell"
vim.opt.completeopt = "menuone,noselect,fuzzy,nosort"
vim.opt.scrolloff = 10
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.indentexpr = "nvim_treesitter#indentexpr()"

--- ShaDa(Shared data) file size limitations
-- '100: 100 files with marks saved
-- <50: 50 lines per register
-- s10: 10kB of size
-- :1000: 1000 lines in CLI history
-- /100: 100 lines in search history
-- @100: 100 lines in input-line history (input boxes, like telescope's?)
-- h keep the hlshearch when loading shada.
vim.opt.shada = "'100,<50,s10,:1000,/100,@100,h"

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

	underline = {
		severity = {
			min = vim.diagnostic.severity.HINT,
			max = vim.diagnostic.severity.ERROR,
		},
	},

	virtual_lines = false,
	virtual_text = { current_line = true },

	update_in_insert = false,
}

vim.api.nvim_create_autocmd({ "FileType" }, {
	callback = function()
		if vim.list_contains(require("nvim-treesitter").get_installed(), vim.bo.ft) then
			vim.wo.foldmethod = "expr"
		else
			vim.wo.foldmethod = "syntax"
		end
	end,
})

MiniDeps.later(function()
	vim.diagnostic.config(diagnostic_opts)
end)

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("my.lsp", {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable()
		end

		if client:supports_method("textDocument/definition") then
			vim.keymap.set("n", "gd", vim.lsp.buf.definition)
		end
		if
			not client:supports_method("textDocument/willSaveWaitUntil")
			and client:supports_method("textDocument/formatting")
		then
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
				buffer = args.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
				end,
			})
		end
	end,
})
