local on_attach = require("DPigeon.functions").lsp_on_attach
local servers = require("DPigeon.tables").servers
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
for k, v in pairs(servers) do
	if k == "elixirls" then
		require("lspconfig")[k].setup {
			cmd = {"elixir-ls"},
			capabilities = capabilities,
			on_attach = on_attach,
			settings = v,
		}
		goto continue
	end
	require("lspconfig")[k].setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = v,
	})
	::continue::
end

local cmp = require("cmp")
local luasnip = require("luasnip")

luasnip.config.setup({})

cmp.setup(require("DPigeon.tables").cmp_configs)
