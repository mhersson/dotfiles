local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- Set nushell with explicit config loading
-- config.default_prog = {
--     "/opt/homebrew/bin/nu",
--     "--config",
--     os.getenv("HOME") .. "/.config/nushell/config.nu",
--     "--env-config",
--     os.getenv("HOME") .. "/.config/nushell/env.nu",
-- }

config.window_background_opacity = 1.00
config.macos_window_background_blur = 95
config.window_decorations = "RESIZE"
config.front_end = "WebGpu"

config.color_scheme = "Catppuccin Mocha"
config.colors = {
    split = "#ffc777",
    cursor_bg = "#FF9433",
    cursor_border = "#FF9433",
    cursor_fg = "#eff1f5",
}
-- Don't dim inactive panes
config.inactive_pane_hsb = {
    saturation = 1.0,
    brightness = 1.0,
}

config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500
config.force_reverse_video_cursor = false

config.audible_bell = "Disabled"

config.font_size = 15
config.font = wezterm.font("FantasqueSansM Nerd Font", { weight = "Medium" })
config.line_height = 1.2

config.pane_focus_follows_mouse = true

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false

config.window_close_confirmation = "NeverPrompt"

config.initial_cols = 185
config.initial_rows = 67

-- Keybindings
config.keys = {
    -- Split pane vertically (cmd+d)
    {
        key = "d",
        mods = "CMD",
        action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    -- Split pane horizontally (cmd+shift+d)
    {
        key = "d",
        mods = "CMD|SHIFT",
        action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    -- Navigate panes with option+arrow keys
    {
        key = "LeftArrow",
        mods = "OPT",
        action = wezterm.action.ActivatePaneDirection("Left"),
    },
    {
        key = "RightArrow",
        mods = "OPT",
        action = wezterm.action.ActivatePaneDirection("Right"),
    },
    {
        key = "UpArrow",
        mods = "OPT",
        action = wezterm.action.ActivatePaneDirection("Up"),
    },
    {
        key = "DownArrow",
        mods = "OPT",
        action = wezterm.action.ActivatePaneDirection("Down"),
    },
}

return config
