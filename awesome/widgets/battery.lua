-------------------------------------------------
-- Battery widget
-------------------------------------------------

local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")

local text = wibox.widget {
  font = "sans 10",
  widget = wibox.widget.textbox,
}

local widget = wibox.widget.background()
widget:set_widget(text)

local bat = io.open("/sys/class/power_supply/BAT0/uevent", "r")
if bat == nil then
  return widget
end
io.close(bat)

gears.timer {
  timeout = 120,
  autostart = true,
  call_now = true,
  callback = function()
    awful.spawn.easy_async_with_shell("cat /sys/class/power_supply/BAT0/uevent", function(out)
      local capacity_raw = string.match(out, "POWER_SUPPLY_CAPACITY=%d*")
      local capacity = string.sub(string.match(capacity_raw, "=%d*"), 2)

      if tonumber(capacity) ~= 100 then
        local status_raw = string.match(out, "POWER_SUPPLY_STATUS=%u")
        local status_stripped = string.match(status_raw, "=%u")
        local status_letter = string.match(status_stripped, "%u"):lower()

        text:set_text(" " .. capacity .. "%")

        local not_charging = status_letter == "d"
        local is_bat_low = tonumber(capacity) < 21
        local color = "#abb2bf"

        if (not_charging) and (is_bat_low) then
          color = "#C34043"
        end

        widget:set_fg(color)
      else
        text:set_text(" full")
        widget:set_fg("#98BB6C")
      end
    end)
  end
}

return wibox.container.margin(widget, 10, 5, 5, 5)
