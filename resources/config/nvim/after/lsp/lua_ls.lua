return {
	on_attach = function(client, _)
		client.server_capabilities.completionProvider.triggerCharacters = { ".", ":", "#", "(" }
	end,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
			workspace = {
				ignoreSubmodules = true,
				library = { vim.env.VIMRUNTIME },
			},
		},
	},
}
