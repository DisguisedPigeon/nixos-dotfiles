local keymaps = require "behavior.keymaps"

return function(wezterm)
  return {
    keys = keymaps.keys,
    leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
    key_tables = keymaps.key_tables,
  }
end
