local capabilities = require "blink.cmp".get_lsp_capabilities({}, true)
return {
  capabilities = capabilities,
  cmd = { "/usr/bin/env", "elixir-ls" },
  filetypes = { "elixir", "eelixir", "heex", "surface" },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local matches = vim.fs.find({ 'mix.exs' }, { upward = true, limit = 2, path = fname })
    local child_or_root_path, maybe_umbrella_path = unpack(matches)

    local root_dir = vim.fs.dirname(maybe_umbrella_path or child_or_root_path)

    on_dir(root_dir)
  end,

  elixirLS = {
    autoBuild = true,
    dialyzerEnabled = true,
    incrementalDialyzer = true,
    fetchDeps = true,
    suggestSpecs = true,
    signatureAfterComplete = true,
    enableTestLenses = true,
  }
}
