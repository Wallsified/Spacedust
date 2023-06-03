-- Here is where our actual startup begins. The idea is that wharever we defined on the run_on_startup function in
-- apps.lua actually launches as well as we add our wallpaper on our screen(s). 
local awful = require('awful')
local apps = require('conf.apps')
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")

local function run_once(cmd)
    local findme = cmd
    local firstspace = cmd:find(' ')
    if firstspace then findme = cmd:sub(0, firstspace - 1) end
    awful.spawn.with_shell(string.format(
                               'pgrep -u $USER -x %s > /dev/null || (%s)',
                               findme, cmd))
end

for _, app in ipairs(apps.run_on_start_up) do run_once(app) end

-- Wallpaper
screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper {
        screen = s,
        widget = {
            {
                image = beautiful.wallpaper,
                upscale = true,
                downscale = true,
                widget = wibox.widget.imagebox
            },
            valign = "center",
            halign = "center",
            tiled = false,
            widget = wibox.container.tile
        }
    }
end)

