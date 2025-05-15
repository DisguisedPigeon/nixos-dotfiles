local language_id_mapping = {
  bib = 'bibtex',
  pandoc = 'markdown',
  plaintex = 'tex',
  rnoweb = 'rsweave',
  rst = 'restructuredtext',
  tex = 'latex',
  text = 'plaintext',
}
local capabilities = require "blink.cmp".get_lsp_capabilities({}, true)
return {
  capabilities = capabilities,
  cmd = { "/usr/bin/env", "ltex-ls-plus" },
  filetypes = { "bib", "context", "gitcommit", "html", "markdown", "org", "pandoc", "plaintex", "quarto", "mail", "mdx", "rmd", "rnoweb", "rst", "tex", "text", "typst", "xhtml" },
  get_language_id = function(_, filetype)
    return language_id_mapping[filetype] or filetype
  end,
  root_markers = { ".git" },
  settings = { ltex = { language = "es-ES" } }
}
