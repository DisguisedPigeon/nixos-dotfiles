return {
  "OXY2DEV/markview.nvim",
  config = function()
    local presets = require "markview.presets"
    local presets = require "markview.extras.checkboxes"
    require("markview").setup {
      latex = {
        enable = true,
      },
      checkboxes = presets.checkboxes.nerd,
      headings = presets.headings.glow,
      horizontal_rules = presets.horizontal_rules.arrowed,
      tables = presets.tables.rounded,
    }
  end,
}
