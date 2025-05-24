local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.window_background_opacity = 1.00
config.macos_window_background_blur = 95

config.front_end = "WebGpu"

config.color_scheme = "catppuccin-mocha"

config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500
config.force_reverse_video_cursor = true

config.audible_bell = "Disabled"

config.font_size = 14
config.font = wezterm.font("RobotoMono Nerd Font", { weight = "Medium" })

config.pane_focus_follows_mouse = true

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false

config.window_close_confirmation = "NeverPrompt"

config.initial_cols = 185
config.initial_rows = 67

return config
