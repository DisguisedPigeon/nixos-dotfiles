return {
  "OXY2DEV/markview.nvim",
  config = function()
    local presets = require "markview.presets"
    require("markview").setup {
      checkboxes = presets.checkboxes.nerd,
      headings = presets.headings.glow_center,
      horizontal_rules = presets.horizontal_rules.thick,
    }
  end,
}
