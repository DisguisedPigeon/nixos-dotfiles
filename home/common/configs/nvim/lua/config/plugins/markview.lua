return {
  "OXY2DEV/markview.nvim",
  config = function()
    local presets = require "markview.presets";

    require("markview").setup {
      markdown = {
        headings = presets.headings.glow,
        horizontal_rules = presets.horizontal_rules.arrowed,
        tables = presets.tables.rounded
      },
    }
  end
}
