-- Hyprland Lua config
-- Translated from hyprland.conf
-- Refer to https://wiki.hypr.land/Configuring/Start/


------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("hypridle")
    hl.exec_cmd("ghostty")
    hl.exec_cmd("firefox")
end)


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        layout      = "dwindle",
        gaps_in     = 1,
        gaps_out    = 5,
        border_size = 3,

        col = {
            active_border   = 0xff8aadf4,
            inactive_border = 0xff494d64,
        },
    },

    group = {
        col = {
            border_active   = 0xfff38ba8,
            border_inactive = 0xff494d64,
        },
        groupbar = {
            enabled = true,
            col = {
                active   = 0xfff38ba8,
                inactive = 0xff494d64,
            },
            render_titles = false,
            gradients     = false,
        },
    },

    misc = {
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        force_default_wallpaper  = 0,
    },

    decoration = {
        rounding = 10,

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },

        shadow = {
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },

        dim_special = 0.0,
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    ecosystem = {
        no_update_news  = true,
        no_donation_nag = true,
    },
})

hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })

hl.animation({ leaf = "windows",          enabled = true, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 7,  bezier = "default",  style = "popin 80%" })
hl.animation({ leaf = "border",           enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade",             enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 6,  bezier = "default" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 5,  bezier = "myBezier", style = "slidevert" })


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout    = "us,no",
        kb_variant   = "",
        kb_model     = "",
        kb_options   = "grp:caps_toggle",
        kb_rules     = "",

        repeat_rate  = 25,
        repeat_delay = 225,

        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll       = false,
            disable_while_typing = true,
        },
    },
})

hl.device({
    name        = "logitech-g602-1",
    sensitivity = 0.2,
})


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({ match = { class = "^feh$" },                                     float = true })
hl.window_rule({ match = { class = "^mpv$" },                                     float = true })
hl.window_rule({ match = { class = "^xeyes$" },                                   float = true })
hl.window_rule({ match = { class = "^Steam$" },                                   float = true })
hl.window_rule({ match = { class = "^signal$" },                                  float = true })
hl.window_rule({ match = { class = "^xfreerdp$" },                                float = true })
hl.window_rule({ match = { class = "^org\\.pulseaudio\\.pavucontrol$" },          float = true })
hl.window_rule({ match = { class = "^blueman-manager$" },                         float = true })
hl.window_rule({ match = { class = "^\\.blueman-manager-wrapped$" },              float = true })
hl.window_rule({ match = { class = "^remote-viewer$" },                           float = true })
hl.window_rule({ match = { class = "^scratchpad$" },                              float = true })
hl.window_rule({ match = { class = "^Slack$",   title = ".Huddle." },             float = true })
hl.window_rule({ match = { class = "^firefox$", title = "^Picture-in-Picture$" }, float = true })


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "ALT"

hl.bind(mainMod .. " + B",              hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))
hl.bind(mainMod .. " + C",              hl.dsp.window.center())
hl.bind(mainMod .. " + E",              hl.dsp.exec_cmd("thunar"))
hl.bind(mainMod .. " + SHIFT + return", hl.dsp.exec_cmd("ghostty"))
hl.bind(mainMod .. " + SHIFT + E",      hl.dsp.exit())
hl.bind(mainMod .. " + F",              hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + space",  hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P",              hl.dsp.exec_cmd("pavucontrol"))
hl.bind(mainMod .. " + Q",              hl.dsp.window.close())
hl.bind(mainMod .. " + return",         hl.dsp.exec_cmd("fuzzel"))
hl.bind(mainMod .. " + R",              hl.dsp.window.alter_zorder({ mode = "top" }))
hl.bind(mainMod .. " + SHIFT + R",      hl.dsp.window.alter_zorder({ mode = "bottom" }))
hl.bind(mainMod .. " + S",              hl.dsp.window.pseudo())
hl.bind(mainMod .. " + G",              hl.dsp.group.toggle())
hl.bind(mainMod .. " + T",              hl.dsp.layout("togglesplit"))

-- Scratchpad
hl.bind(mainMod .. " + grave",         hl.dsp.workspace.toggle_special(""))
hl.bind(mainMod .. " + SHIFT + grave", hl.dsp.window.move({ workspace = "special" }))

-- Media controls
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

-- Screenshots
hl.bind(mainMod .. " + SHIFT + F11", hl.dsp.exec_cmd([[grim -g "$(slurp)" - | wl-copy]]))
hl.bind(mainMod .. " + F11",         hl.dsp.exec_cmd([[grim -g "$(slurp)" - | swappy -f -]]))

-- Toggle monitor resolution / restart portal
hl.bind(mainMod .. " + SHIFT + F12", hl.dsp.exec_cmd("~/.config/hypr/toggle-resolution"))
hl.bind(mainMod .. " + F12",         hl.dsp.exec_cmd("~/.config/hypr/restart-xdg-desktop-portal"))

-- Window focus
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "r" }))

-- Swap windows
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.swap({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.swap({ direction = "d" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.swap({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.swap({ direction = "r" }))

-- Move windows
hl.bind(mainMod .. " + SUPER + h", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SUPER + j", hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. " + SUPER + k", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SUPER + l", hl.dsp.window.move({ direction = "r" }))

-- Resize active window
hl.bind(mainMod .. " + CONTROL + h", hl.dsp.window.resize({ x = -50, y = 0,   relative = true }))
hl.bind(mainMod .. " + CONTROL + j", hl.dsp.window.resize({ x = 0,   y = 50,  relative = true }))
hl.bind(mainMod .. " + CONTROL + k", hl.dsp.window.resize({ x = 0,   y = -50, relative = true }))
hl.bind(mainMod .. " + CONTROL + l", hl.dsp.window.resize({ x = 50,  y = 0,   relative = true }))

-- Move window in/out of group
hl.bind("SUPER + SHIFT + h", hl.dsp.window.move({ direction = "l", group_aware = true }))
hl.bind("SUPER + SHIFT + j", hl.dsp.window.move({ direction = "d", group_aware = true }))
hl.bind("SUPER + SHIFT + k", hl.dsp.window.move({ direction = "u", group_aware = true }))
hl.bind("SUPER + SHIFT + l", hl.dsp.window.move({ direction = "r", group_aware = true }))

-- Switch active window in group
for i = 1, 9 do
    hl.bind("SUPER + " .. i, hl.dsp.group.active({ index = i }))
end

-- Move active window within group
hl.bind("SUPER + SHIFT + f", hl.dsp.group.move_window({ forward = true }))
hl.bind("SUPER + SHIFT + b", hl.dsp.group.move_window({ forward = false }))

-- Workspaces: switch + move (silent)
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Scroll through existing workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Mouse drag/resize
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
