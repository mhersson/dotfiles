local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.front_end = "WebGpu"

config.color_scheme = "catppuccin-mocha"

config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500

config.audible_bell = "Disabled"

config.font_size = 15
config.font = wezterm.font({ family = "JetBrainsMono Nerd Font" })

config.pane_focus_follows_mouse = true

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false

return config
