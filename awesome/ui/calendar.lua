local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi

local styles = {}

styles.month = {
    padding = dpi(10),
    markup = function(t) return '<b>' .. t .. '</b>' end
}

styles.normal = {
    fg_color = beautiful.white,
    markup = function(t)
        return "<span font_desc='" .. beautiful.font .. "'>" .. t .. "</span>"
        -- return '<span font_desc='" .. beautiful.font_name .. "'>" '</b>'
    end
}

styles.focus = {
    fg_color = beautiful.orange,
    bg_color = beautiful.bg_normal,
    markup = function(t)
        return "<span font_desc='" .. beautiful.font_name .. "'>" .. t ..
                   "</span>"
    end,
    padding = dpi(5)
}

styles.header = {
    markup = function(t)
        return "<span font_desc='" .. beautiful.font_name .. "'>" .. t ..
                   "</span>"
    end
}
styles.weekday = {
    fg_color = beautiful.white,
    markup = function(t)
        return "<span font_desc='" .. beautiful.font_name .. "'>" .. t ..
                   "</span>"
    end
}

local function decorate_cell(widget, flag, date)
    if flag == "monthheader" and not styles.monthheader then flag = "header" end
    local props = styles[flag] or {}
    if props.markup and widget.get_text and widget.set_markup then
        widget:set_markup(props.markup(widget:get_text()))
    end
    -- Change bg color for weekends
    local default_bg = beautiful.bg_normal
    local ret = wibox.widget {
        {
            widget,
            margins = (props.padding or 2) + (props.border_width or 0),
            widget = wibox.container.margin
        },
        shape = props.shape,
        fg = props.fg_color or beautiful.white,
        bg = props.bg_color or default_bg,
        widget = wibox.container.background
    }
    return ret
end

local calendar_widget = wibox.widget {
    date = os.date("*t"),
    font = beautiful.font_name,
    spacing = dpi(15),
    flex_height = true,
    fn_embed = decorate_cell,
    widget = wibox.widget.calendar.month
}

local calendar = awful.popup {
    widget = {
        widget = wibox.container.margin,
        font = beautiful.font,
        margins = dpi(10),
        calendar_widget
    },
    bg = beautiful.bg_normal,
    visible = false,
    border_width = dpi(2),
    border_color = beautiful.orange2,
    placement = function(c)
        (awful.placement.centered)(c, {margins = {bottom = dpi(230)}})
    end,
    shape = gears.shape.rounded_rect,
    ontop = true,
    hide_on_right_click = false
}

local current_month = os.date("*t").month
calendar_widget:buttons(gears.table
                            .join( -- Left Click - Reset date to current date
                            awful.button({}, 1, function()
        calendar_widget.date = os.date "*t"
    end), -- Scroll - Move to previous or next month
    awful.button({}, 4, function()
        new_calendar_month = calendar_widget.date.month - 1
        if new_calendar_month == current_month then
            calendar_widget.date = os.date "*t"
        else
            calendar_widget.date = {
                month = new_calendar_month,
                year = calendar_widget.date.year
            }
        end
    end), awful.button({}, 5, function()
        new_calendar_month = calendar_widget.date.month + 1
        if new_calendar_month == current_month then
            calendar_widget.date = os.date "*t"
        else
            calendar_widget.date = {
                month = new_calendar_month,
                year = calendar_widget.date.year
            }
        end
    end)))

local function toggle() calendar.visible = not calendar.visible end

return toggle
