local wezterm = require("wezterm")

local module = {}

function module.apply(config)
	config.font_size = 11.5

	-- use JetBrains Mono as default and VictorMono for italics
	config.font = wezterm.font({ family = "JetBrains Mono Nerd Font", weight = "Regular" })
	config.font_rules = {
		{
			intensity = "Bold",
			italic = true,
			font = wezterm.font({
				family = "VictorMono Nerd Font",
				weight = "Bold",
				style = "Italic",
			}),
		},
		{
			intensity = "Normal",
			italic = true,
			font = wezterm.font({
				family = "VictorMono Nerd Font",
				weight = "Bold",
				style = "Italic",
			}),
		},
	}
end

return module
