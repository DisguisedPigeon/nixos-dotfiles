local capabilities = require "blink.cmp".get_lsp_capabilities(
  { textDocument = { completion = { completionItem = { snippetSupport = true } } } },
  true)

return {
  cmd = { "/usr/bin/env", "vscode-html-language-server", "--stdio" },
  filetypes = { "html", "templ" },
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
      css = true,
      javascript = true
    },
    provideFormatter = true
  },
  root_markers = { "package.json", ".git" },
  settings = {},
  capabilities = capabilities
}
