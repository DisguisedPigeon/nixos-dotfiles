local add, later = MiniDeps.add, MiniDeps.later
local now_if_args = _G.Config.now_if_args

--#region treesitter
now_if_args(function()
	add({
		source = "nvim-treesitter/nvim-treesitter",
		checkout = "main",
		hooks = {
			post_checkout = function()
				vim.cmd("TSUpdate")
			end,
		},
	})

	add({
		source = "nvim-treesitter/nvim-treesitter-textobjects",
		checkout = "main",
	})

	-- subset of this list with stuff I actually might use. Maybe overkill.
	--   :=require('nvim-treesitter').get_available()
	--   https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md
	local languages = {
		"bash",
		"bibtex",
		"c",
		"cmake",
		"cpp",
		"css",
		"csv",
		"desktop",
		"diff",
		"dockerfile",
		"elixir",
		"erlang",
		"git_config",
		"git_rebase",
		"gitattributes",
		"gitcommit",
		"gitignore",
		"gleam",
		"go",
		"gomod",
		"heex",
		"html",
		"html_tags",
		"http",
		"java",
		"javadoc",
		"javascript",
		"jq",
		"jsdoc",
		"json",
		"json5",
		"latex",
		"lua",
		"luadoc",
		"make",
		"markdown",
		"markdown_inline",
		"mermaid",
		"nix",
		"nu",
		"ocaml",
		"ocaml_interface",
		"ocamllex",
		"python",
		"query",
		"regex",
		"rust",
		"sql",
		"ssh_config",
		"tmux",
		"typescript",
		"typespec",
		"typst",
		"vim",
		"vimdoc",
		"xcompose",
		"xml",
		"xresources",
		"yaml",
		"yuck",
		"zig",
	}
	local to_install = vim.tbl_filter(function(lang)
		return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) == 0
	end, languages)
	if #to_install > 0 then
		require("nvim-treesitter").install(to_install)
	end

	local filetypes = {}
	for _, lang in ipairs(languages) do
		for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
			table.insert(filetypes, ft)
		end
	end
	local ts_start = function(ev)
		vim.treesitter.start(ev.buf)
	end
	_G.Config.new_autocmd("FileType", filetypes, ts_start, "Start tree-sitter")
end)
--#endregion

--#region LSP/Formatting
now_if_args(function()
	add("neovim/nvim-lspconfig")
	vim.lsp.enable({
		"cssls",
		"elp",
		"gleam",
		"lua_ls",
		"nil_ls",
		"nixd",
		"nushell",
		"ocamllsp",
		"rust_analyzer",
		"superhtml",
		"tailwindcss",
		"ts_ls",
	})
end)

later(function()
	add("stevearc/conform.nvim")
	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			gleam = { "gleam" },
			erlang = { "rebar3 fmt" },
		},
	})
end)
--#endregion

later(function()
	add("rafamadriz/friendly-snippets")
end)

--MiniDeps.now(function()
--  add({ source = "catppuccin/nvim", name = "catppuccin" })
--  require("catppuccin").setup({
--    transparent_background = true,
--    styles = { keywords = { "bold" }, types = { "bold", "italic" } },
--  })
--  vim.cmd("color catppuccin-macchiato")
--end)

MiniDeps.now(function()
	add({ source = "rose-pine/nvim", name = "rose-pine" })
	require("rose-pine").setup({ styles = { transparency = true } })
	vim.cmd("color rose-pine")
end)

later(function()
	add("stevearc/oil.nvim")
	require("oil").setup()
end)

later(function()
	add({
		source = "vyfor/cord.nvim",
		hooks = {
			post_checkout = function()
				vim.cmd(":Cord update")
			end,
		},
	})
	require("cord").setup({
		editor = {
			tooltip = "BTW",
		},
		timestamp = {
			enabled = false,
		},
	})
end)

later(function()
	add("vieitesss/miniharp.nvim")
	local miniharp = require("miniharp")
	miniharp.setup({
		autoload = true,
		autosave = true,
		show_on_autoload = true,
	})
end)

later(function()
	add("OXY2DEV/markview.nvim")
	local presets = require("markview.presets")

	require("markview").setup({
		markdown = {
			headings = presets.headings.glow,
			tables = presets.tables.rounded,
		},
	})
end)
