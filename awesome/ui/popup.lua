local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi

local rubato = require "lib.rubato"

----- Var -----

width = dpi(300)
height = dpi(120)

----- Skeleton -----

local icon = wibox.widget {
    font = beautiful.icon_font .. " 22",
    markup = "",
    widget = wibox.widget.textbox
}

local name = wibox.widget {
    font = beautiful.icon_font .. " 22",
    -- markup = "Volume",
    widget = wibox.widget.textbox
}

-- the progress bar

local progress = wibox.widget {
    margins = {top = dpi(6), bottom = dpi(6)},
    max_value = 100,
    min_value = 0,
    shape = gears.shape.rounded_bar,
    bar_shape = gears.shape.rounded_bar,
    background_color = beautiful.blue_second,
    color = beautiful.blue,
    bar_border_width = dpi(0),
    widget = wibox.widget.progressbar
}

-- the slider

local slider = wibox.widget {
    shape = gears.shape.rounded_bar,
    bar_margins = {top = dpi(6), bottom = dpi(6)},
    maximum = 100,
    minimum = 0,
    value = 0,
    -- Sliderr
    bar_active_color = beautiful.blue,
    bar_color = beautiful.blue_second,
    bar_shape = gears.shape.rounded_bar,
    -- Handle
    handle_shape = gears.shape.circle,
    handle_border_width = dpi(2),
    handle_border_color = beautiful.bar_alt,
    handle_color = beautiful.blue,
    handle_width = dpi(30),
    widget = wibox.widget.slider
}

-- slider's behavior (kinda)...

-- slider:connect_signal("property::value", function(_, newValue)
--  awful.spawn.with_shell("amixer -D pulse set Master " .. newValue .. "%")
-- end)

----- The Popup ----- 

local popup = awful.popup {
    ontop = true,
    visible = false,
    placement = function(c)
        awful.placement.top_right(c,
                                  {margins = {top = dpi(60), right = dpi(20)}})
    end,
    shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 10) end,
    -- the idea here is that the popup follows the focuses screen, but it just doesn't do it until you restart the wm. 
    screen = awful.screen.focused({client = true, mouse = true}),
    hide_on_right_click = true,
    widget = wibox.container.margin
}

-- It's widget/Setup

popup:setup{
    {
        {
            {
                icon,
                {name, progress, layout = wibox.layout.align.vertical},
                spacing = dpi(10),
                layout = wibox.layout.fixed.horizontal
            },
            margins = {
                top = dpi(40),
                bottom = dpi(40),
                left = dpi(30),
                right = dpi(30)
            },
            widget = wibox.container.margin
        },
        halign = 'center',
        valign = 'center',
        widget = wibox.container.place
    },
    forced_height = height,
    forced_width = width,
    bg = beautiful.bar,
    widget = wibox.container.background
}

local slide = rubato.timed {
    pos = 0,
    rate = 60,
    intro = 0.05,
    duration = 0.2,
    subscribed = function(pos) progress.value = pos end
}

-- Timeout

local timeout = gears.timer {
    timeout = 1,
    single_shot = true,
    autostart = false,
    call_now = false,
    callback = function()
        popup.visible = false
        slide.target = 0
    end
}

-- Connect to a signal "awesome/signals/volume"

local first_time = true
awesome.connect_signal("signal::volume", function(vol, mute)

    if first_time then
        first_time = false
    else
        popup.visible = true
        -- name.markup = "Volume"
        progress.color = beautiful.orange

        if mute == 1 or vol == 0 then
            slide.target = 0
            icon.markup = ""
        else
            slide.target = vol
            if vol >= 75 then
                icon.markup = ""
            else
                icon.markup = ""
            end
        end

        if popup.visible then
            timeout:again()
        else
            timeout:start()
        end
    end
end)

-- Connect to a signal "awesome/signals/brightness"

local second_time = true
awesome.connect_signal("signal::brightness", function(bri)

    if second_time then
        second_time = false
    else
        popup.visible = true

        slide.target = bri
        progress.color = beautiful.orange
        -- name.markup = "Brightness"
        icon.markup = ""

        if popup.visible then
            timeout:again()
        else
            timeout:start()
        end
    end
end)
