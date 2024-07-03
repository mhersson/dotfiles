local wezterm = require("wezterm")

local module = {}

function module.apply(config)
	config.font_size = 12

	config.font = wezterm.font({ family = "Hack Nerd Font" })

	config.font_rules = {
		{
			intensity = "Bold",
			italic = false,
			font = wezterm.font({
				family = "Hack Nerd Font",
				weight = "Bold",
				-- style = "Italic",
			}),
		},
		{
			italic = true,
			font = wezterm.font({
				family = "Hack Nerd Font",
				style = "Italic",
			}),
		},
	}
end

return module
