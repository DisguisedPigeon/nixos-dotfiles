return {
  dir = "~/Personal/testerm.nvim",
  config = function()
    local testerm = require "testerm"
    testerm.setup {}
    vim.keymap.set("n", "<leader>ñx", testerm.executeCommand)
    vim.keymap.set("n", "<leader>ñt", testerm.toggle)
  end

}
