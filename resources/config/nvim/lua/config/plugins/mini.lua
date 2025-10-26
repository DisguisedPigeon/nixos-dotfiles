return {
  "echasnovski/mini.nvim",
  config = function()
    local statusline = require "mini.statusline"
    local surround = require "mini.surround"
    local icons = require "mini.icons"
    local ai = require "mini.ai"
    local operators = require "mini.operators"
    local starter = require "mini.starter"
    local misc = require "mini.misc"
    misc.setup_termbg_sync()

    statusline.setup { use_icons = true }
    surround.setup {}
    icons.setup {}
    ai.setup {}
    starter.setup {}
    operators.setup {}
  end,
}
