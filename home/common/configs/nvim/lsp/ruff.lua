return {
  cmd = { "/bin/env", "ruff", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
  init_options = { settings = {} }
}
