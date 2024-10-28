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

config.font_size = 14
config.font = wezterm.font({ family = "MesloLGS Nerd Font" })

config.pane_focus_follows_mouse = true

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false

config.window_close_confirmation = "NeverPrompt"

config.initial_cols = 220
config.initial_rows = 72

return config
