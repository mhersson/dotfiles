-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- set the color scheme:
config.color_scheme = "Tokyo Night Moon"

-- set initial window size
config.initial_rows = 24
config.initial_cols = 80

-- set cursor style
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500

-- disable audible bell
config.audible_bell = "Disabled"

local fonts = require("fonts")
fonts.apply(config)

local tabs = require("tabs")
tabs.apply(config)

return config
