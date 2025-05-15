local capabilities = require "blink.cmp".get_lsp_capabilities({}, true)
return {
  capabilities = capabilities,
  cmd = { "/usr/bin/env", "gleam", "lsp" },
  filetypes = { "gleam" },
  root_markers = { "gleam.toml", ".git" }
}
