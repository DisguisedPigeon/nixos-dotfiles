local on_attach = require("DPigeon.functions").lsp_on_attach
local servers = require("DPigeon.tables").servers

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local function merge_tables(t1, t2)
	local result = {}
	for k, v in pairs(t1) do
		result[k] = v
	end
	for k, v in pairs(t2) do
		result[k] = v
	end
	return result
end

for k, v in pairs(servers) do
	require("lspconfig")[k].setup(
		merge_tables(
			{ capabilities = capabilities, on_attach = on_attach },
			v
		))
end

local cmp = require("cmp")
local luasnip = require("luasnip")

luasnip.config.setup({})

cmp.setup(require("DPigeon.tables").cmp_configs)
