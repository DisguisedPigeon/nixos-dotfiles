local none_ls = require("null-ls")
local sources = {
	-- python
	none_ls.builtins.formatting.black.with({
		extra_args = { "--line-length=80" },
	}),
	none_ls.builtins.formatting.isort,
}

none_ls.setup({ sources = sources })
