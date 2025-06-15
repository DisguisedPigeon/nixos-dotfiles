return function(wezterm)
  local my_rose_pine = wezterm.color.get_builtin_schemes()['Rosé Pine Moon (base16)']
  my_rose_pine.background = '#000000'

  return {
    font = wezterm.font_with_fallback {
      "Maple Mono NF",
      "Noto Color Emoji"
    },
    use_cap_height_to_scale_fallback_fonts = true,
    allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace",
    font_size = 12,
    window_background_opacity = 0.9,

    hide_tab_bar_if_only_one_tab = true,

    window_frame = {
      font = wezterm.font "Maple Mono NF",

      active_titlebar_bg = '#11111b',

      inactive_titlebar_bg = '#181825',
    },

    -- colors = require "appearance.colors"
    color_schemes = { ['RP'] = my_rose_pine },
    color_scheme = 'RP'
  }
end
