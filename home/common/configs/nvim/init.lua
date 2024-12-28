require "config.lazy"
require "config.opts"
require "config.keybinds"

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on text yank",
  group = vim.api.nvim_create_augroup("DPigeon-Yank-Highlight", { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})
