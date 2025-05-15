local capabilities = require "blink.cmp".get_lsp_capabilities({}, true)
return {
  capabilities = capabilities,
  cmd = { "nixd" },
  filetypes = { "nix" },
  root_markers = { "flake.nix", "git" }
}
