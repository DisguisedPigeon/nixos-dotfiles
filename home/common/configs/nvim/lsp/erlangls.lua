local capabilities = require "blink.cmp".get_lsp_capabilities({}, true)
return {
  capabilities = capabilities,
  cmd = { "erlang_ls" },
  filetypes = { "erlang" },
  root_markers = { "rebar.config", "erlang.mk", ".git" },
}
