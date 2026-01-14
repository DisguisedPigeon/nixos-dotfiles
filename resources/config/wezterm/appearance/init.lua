return function(wezterm)
  return {
    font = wezterm.font_with_fallback {
      "Maple Mono NF",
      "Noto Color Emoji",
    },
    use_cap_height_to_scale_fallback_fonts = true,
    allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace",
    font_size = 15,
    window_background_opacity = 0.9,

    hide_tab_bar_if_only_one_tab = true,

    window_frame = {
      font = wezterm.font "Maple Mono NF",

      active_titlebar_bg = "#11111b",

      inactive_titlebar_bg = "#181825",
    },

    color_scheme = "Rosé Pine (base16)",
  }
end
