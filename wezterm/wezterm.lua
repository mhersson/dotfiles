local wezterm = require("wezterm")

local config = {}

-- Function to get git project name from a path
local function get_git_project_name(cwd)
    if not cwd then
        return nil
    end

    -- Walk up the directory tree looking for .git
    local path = cwd
    while path and path ~= "/" and path ~= "" do
        local git_dir = path .. "/.git"
        local f = io.open(git_dir, "r")
        if f then
            f:close()
            -- Found .git, return the directory name
            return path:match("([^/]+)$")
        end
        -- Go up one directory
        path = path:match("(.+)/[^/]*$")
    end
    return nil
end

-- Custom tab title showing git project name if available
wezterm.on("format-tab-title", function(tab)
    local pane = tab.active_pane
    local cwd = pane.current_working_dir

    -- Get the foreground process name
    local process = pane.foreground_process_name or ""
    process = process:match("([^/]+)$") or "" -- Get basename

    local project = nil
    if cwd then
        project = get_git_project_name(cwd.file_path)
    end

    -- If we have a project and a known editor process, show "editor project"
    if project and (process == "hx" or process == "nvim" or process == "vim") then
        return " " .. process .. " " .. project .. " "
    end

    -- If we have a project, show just the project name
    if project then
        return " " .. project .. " "
    end

    -- Fall back to the process name
    local title = pane.title
    if title and #title > 0 then
        return " " .. title .. " "
    end
    return " Terminal "
end)

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
config.window_decorations = "RESIZE"
config.front_end = "WebGpu"

config.color_scheme = "Everforest Dark (Gogh)"
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
config.font = wezterm.font("FantasqueSansM Nerd Font")
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
