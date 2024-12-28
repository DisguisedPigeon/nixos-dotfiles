return {
  "echasnovski/mini.nvim",
  config = function()
    local statusline = require "mini.statusline"
    local surround = require "mini.surround"
    local icons = require "mini.icons"
    statusline.setup { use_icons = true }
    surround.setup {}
    icons.setup {}
  end,
}
