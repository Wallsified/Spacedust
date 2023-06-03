local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local height = dpi(250)
local width = dpi(780)

-- Commands
local poweroff_command = function()
    awful.spawn.with_shell("poweroff")
    awesome.emit_signal("ui::powermenu:hide")
end

local reboot_command = function()
    awful.spawn.with_shell("reboot")
    awesome.emit_signal("ui::powermenu:hide")
end

local lock_command = function()
    awesome.emit_signal("ui::powermenu:hide")
    awful.spawn.with_shell("betterlockscreen -l")
end

local suspend_command = function()
    lock_command()
    awful.spawn.with_shell("systemctl suspend")
end

local exit_command = function() awesome.quit() end

local createButtons = function(icon, text, command)

    local widget = wibox.widget {
        {
            {
                {
                    {
                        markup = icon,
                        align = 'center',
                        font = "Font Awesome 35",
                        widget = wibox.widget.textbox
                    },
                    {
                        markup = text,
                        align = 'center',
                        font = beautiful.font_name .. " 14",
                        widget = wibox.widget.textbox
                    },
                    spacing = dpi(10),
                    layout = wibox.layout.fixed.vertical
                },
                halign = 'center',
                valign = 'center',
                widget = wibox.container.place
            },
            margins = dpi(20),
            widget = wibox.container.margin
        },
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 20) end,
        bg = beautiful.bar,
        widget = wibox.container.background
    }

    widget:connect_signal("mouse::enter", function()
        if widget.bg ~= beautiful.blue_second then
            widget.backup = widget.bg
            widget.has_backup = true
        end
        widget.bg = beautiful.blue_second
    end)

    widget:connect_signal("mouse::leave", function()
        if widget.has_backup then widget.bg = widget.backup end
    end)

    widget:buttons(gears.table.join(awful.button({}, 1, function()
        awful.spawn(command)
    end)))

    return widget
end

local p = function(s)

    s.powermenu = wibox {
        ontop = true,
        visible = false,
        type = 'splash',
        bg = "#0a1e24f",
        height = s.geometry.height,
        width = s.geometry.width,
        x = s.geometry.x,
        y = s.geometry.y,
        widget = wibox.container.margin
    }

    awful.placement.centered(s.powermenu)

    -- These are the mouse bindings, i think. 
    s.powermenu:buttons(gears.table.join(
                            awful.button({}, 2, function()
            awesome.emit_signal('ui::powermenu:hide')
        end), awful.button({}, 3, function()
            awesome.emit_signal('ui::powermenu:hide')
        end), awful.button({}, 1, function()
            awesome.emit_signal('ui::powermenu:hide')
        end)))

    -- Test buttons goes here

    local poweroff = createButtons("", "Power Off", poweroff_command)
    local reboot = createButtons("", "Reboot", reboot_command)
    local end_session = createButtons("", "End Session", exit_command)
    local suspend = createButtons("", "Suspend", suspend_command)
    local lock = createButtons("", "Lock", lock_command)

    s.powermenu:setup{
        nil,
        {
            nil,
            {
                {
                    {
                        poweroff,
                        reboot,
                        suspend,
                        end_session,
                        lock,
                        spacing = dpi(20),
                        layout = wibox.layout.fixed.horizontal
                    },
                    margins = dpi(35),
                    widget = wibox.container.margin
                },
                forced_width = width,
                forced_height = height,
                shape = function(cr, w, h)
                    gears.shape.rounded_rect(cr, w, h, dpi(20))
                end,
                bg = beautiful.bar,
                widget = wibox.container.background
            },
            nil,
            layout = wibox.layout.align.vertical,
            expand = "none"
        },
        nil,
        layout = wibox.layout.align.horizontal,
        expand = "none"
    }
end

local p_grabber = awful.keygrabber({
    auto_start = true,
    stop_event = "release",
    keypressed_callback = function(self, mod, key, command)
        if key == "s" then
            suspend_command()
        elseif key == "q" then
            exit_command()
        elseif key == "l" then
            lock_command()
        elseif key == "p" then
            poweroff_command()
        elseif key == "r" then
            reboot_command()
        elseif key == "Escape" then
            awesome.emit_signal("ui::powermenu:hide")
        end
    end
})

screen.connect_signal('request::desktop_decoration', function(s) p(s) end)

screen.connect_signal('removed', function(s) p(s) end)

awesome.connect_signal("ui::powermenu:open", function()
    for s in screen do s.powermenu.visible = true end
    awful.screen.focused().powermenu.visible = true
    p_grabber:start()
end)

awesome.connect_signal("ui::powermenu:hide", function()
    p_grabber:stop()
    for s in screen do s.powermenu.visible = false end
end)

