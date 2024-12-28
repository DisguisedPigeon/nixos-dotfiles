return {
  "stevearc/oil.nvim",
  dependencies = { "echasnovski/mini.nvim" },
  config = function()
    local oil = require "oil"
    oil.setup()
    vim.keymap.set("n", "-", oil.open, { desc = "Open oil [E]xplorer" })
  end,
}
