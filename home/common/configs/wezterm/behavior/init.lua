local keymaps = require "behavior.keymaps"

return function(wezterm)
  return {
    keys = keymaps.keys,
    key_tables = keymaps.key_tables
  }
end
