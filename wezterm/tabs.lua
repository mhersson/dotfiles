-- local wezterm = require("wezterm")

local module = {}

function module.apply(config)
	config.hide_tab_bar_if_only_one_tab = true

	config.tab_bar_at_bottom = true

	config.show_new_tab_button_in_tab_bar = false

	config.use_fancy_tab_bar = false

	-- config.window_frame = {
	-- 	font_size = 10,
	-- }
	-- -- The filled in variant of the < symbol
	-- local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
	--
	-- -- The filled in variant of the > symbol
	-- local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider
	--
	-- -- This function returns the suggested title for a tab.
	-- -- It prefers the title that was set via `tab:set_title()`
	-- -- or `wezterm cli set-tab-title`, but falls back to the
	-- -- title of the active pane in that tab.
	-- function tab_title(tab_info)
	-- 	local title = tab_info.tab_title
	-- 	-- if the tab title is explicitly set, take that
	-- 	if title and #title > 0 then
	-- 		return title
	-- 	end
	-- 	-- Otherwise, use the title from the active pane
	-- 	-- in that tab
	-- 	return tab_info.active_pane.title
	-- end
	--
	-- wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	-- 	local edge_background = "#24273a"
	-- 	local background = "#24273a"
	-- 	local foreground = "#cad3f5"
	--
	-- 	if tab.is_active then
	-- 		background = "#8aadf4"
	-- 		foreground = "#24273a"
	-- 	elseif hover then
	-- 		background = "#3b3052"
	-- 		foreground = "#909090"
	-- 	end
	--
	-- 	local edge_foreground = background
	--
	-- 	local title = tab_title(tab)
	--
	-- 	-- ensure that the titles fit in the available space,
	-- 	-- and that we have room for the edges.
	-- 	title = wezterm.truncate_right(title, max_width - 2)
	--
	-- 	return {
	-- 		{ Background = { Color = edge_background } },
	-- 		{ Foreground = { Color = edge_foreground } },
	-- 		{ Text = SOLID_LEFT_ARROW },
	-- 		{ Background = { Color = background } },
	-- 		{ Foreground = { Color = foreground } },
	-- 		{ Text = title },
	-- 		{ Background = { Color = edge_background } },
	-- 		{ Foreground = { Color = edge_foreground } },
	-- 		{ Text = SOLID_RIGHT_ARROW },
	-- 	}
	-- end)
end

return module
