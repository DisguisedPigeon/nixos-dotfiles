return function(wezterm)
  return {
    font = wezterm.font_with_fallback {
      "Maple Mono NF",
      "Noto Color Emoji"
    },
    font_size = 12,
    window_background_opacity = 0.8,

    hide_tab_bar_if_only_one_tab = true,

    window_frame = {
      font = wezterm.font { family = 'DejaVu Sans' },

      active_titlebar_bg = '#11111b',

      inactive_titlebar_bg = '#181825',
    },

    colors = require "appearance.colors"
  }
end
