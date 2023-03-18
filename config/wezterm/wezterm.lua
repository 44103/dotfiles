local wezterm = require 'wezterm'

return {
  font = wezterm.font_with_fallback {
    {
      family = "Ricty",
      weight = "Regular",
      stretch = "Normal",
      style = "Normal"
    }
  },
  font_size = 12.7,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false
}
