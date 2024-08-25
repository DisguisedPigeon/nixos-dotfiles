--[[ solo_instalar_wtf = {
	"theprimeagen/harpoon",
	"mbbill/undotree",
	"L3MON4D3/luasnip",
	"tpope/vim-fugitive",
	"lspconfig",
	"cmp"
}
]]
require("fidget").setup()
require("oil").setup()
require("glow").setup()
require("nvim-treesitter.configs").setup(require("DPigeon.tables").treesitter_configs)
require("Comment").setup()
require("todo-comments").setup()
require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
	on_attach = require("DPigeon.functions").gitsigns_on_attach,
})
require("lualine").setup({
	options = {
		icons_enabled = false,
		theme = "onedark",
		component_separators = "|",
		section_separators = "",
	},
})
