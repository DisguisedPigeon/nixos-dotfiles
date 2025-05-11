local wezterm = require "wezterm"
local config = wezterm.config_builder()

-- Appearance --
local appearance_config = require "appearance" (wezterm)

for key, value in pairs(appearance_config) do
  config[key] = value
end



-- Behavior --
local behavior_config = require "behavior" (wezterm)

for key, value in pairs(behavior_config) do
  config[key] = value
end


return config
