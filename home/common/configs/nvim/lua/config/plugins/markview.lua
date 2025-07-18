return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  priority = 49,
  config = function()
    local presets = require "markview.presets"

    require("markview").setup {
      markdown = {
        headings = presets.headings.glow,
        tables = presets.tables.rounded,
      },
    }
  end,
}
