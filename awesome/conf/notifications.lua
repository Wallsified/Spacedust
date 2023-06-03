local naughty = require('naughty')
local awful = require("awful")
local gears = require('gears')
local beautiful = require("beautiful")
local dpi = require('beautiful').xresources.apply_dpi
local ruled = require("ruled")

naughty.config.padding = dpi(400)
naughty.config.spacing = 8

naughty.config.defaults.ontop = true
naughty.config.defaults.screen = awful.screen.focused()
naughty.config.defaults.margin = beautiful.notification_margin
naughty.config.defaults.position = 'top_right'

naughty.config.defaults.fg = beautiful.white

naughty.config.defaults.opacity = 1.0
naughty.config.defaults.icon = nil
naughty.config.defaults.icon_size = dpi(26)
naughty.config.defaults.shape = gears.shape.rounded_rect
naughty.config.defaults.border_width = dpi(2)
naughty.config.defaults.border_color = beautiful.orange2
naughty.config.defaults.hover_timeout = nil
naughty.config.defaults.margin = 15

naughty.config.presets.normal = {
    fg = beautiful.fg_normal,
    bg = beautiful.blue_main
}

naughty.config.presets.low = {
    fg = beautiful.fg_normal,
    bg = beautiful.blue_main
}

naughty.config.presets.critical = {
    fg = beautiful.fg_normal,
    bg = beautiful.orange2
    -- timeout = 0,
}

-- Error handling
if _G.awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = ' 4x4 aint 12 mate. Check the startup',
        text = _G.awesome.startup_errors
    })
end

do
    local in_error = false
    _G.awesome.connect_signal('debug::error', function(err)
        if in_error then return end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = " That's a Bad Kitty. Something went wrong.",
            text = tostring(err)
        })
        in_error = false
    end)
end

function log_this(title, txt)
    naughty.notify({title = 'log: ' .. title, text = txt})
end

ruled.notification.connect_signal('request::rules', function()
    ruled.notification.append_rule {
        rule = {},
        properties = {screen = awful.screen.preferred, implicit_timeout = 5}
    }
end)

naughty.connect_signal("request::display",
                       function(n) naughty.layout.box {notification = n} end)
