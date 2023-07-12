local gfs = require("gears.filesystem")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local awm_icon = beautiful.awesome_icon
local batteryarc_widget = require(
                              "awesome-wm-widgets.batteryarc-widget.batteryarc")
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
local spotify_widget = require("awesome-wm-widgets.spotify-widget.spotify")

----- Bar -----

launcher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = mainmenu
})

screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag({"1", "2", "3", "4"}, s, awful.layout.layouts[1])

    ----- Making Variables -----

    -- Time

    local hour = wibox.widget {widget = wibox.widget.textbox}

    local icon = wibox.widget {
        font = beautiful.icon_font,
        markup = "<span foreground='" .. beautiful.orange .. "'>  </span>",
        widget = wibox.widget.textbox
    }

    local time = wibox.widget {
        {
            {
                icon,
                hour,
                spacing = dpi(4),
                layout = wibox.layout.fixed.horizontal
            },
            margins = dpi(4),
            widget = wibox.container.margin
        },
        buttons = {awful.button({}, 1, function() require "ui.calendar"() end)},
        bg = beautiful.bar,
        widget = wibox.container.background
    }

    local set_clock = function() -- Update the value of the clock
        _ = os.date("%d %B %Y, %H:%M")
        hour.markup = "<span foreground='" .. beautiful.orange .. "'>" .. _ ..
                          "</span>"
    end

    local update_clock = gears.timer { -- Timer every 5 sec
        timeout = 5,
        autostart = true,
        call_now = true,
        callback = function() set_clock() end
    }

    local volume = wibox.widget {
        {
            {
                {
                    id = "vol_icon",
                    font = beautiful.icon_font,
                    markup = "<span foreground='" .. beautiful.orange ..
                        "'></span>",
                    widget = wibox.widget.textbox
                },
                {id = "value", markup = "", widget = wibox.widget.textbox},
                spacing = dpi(4),
                id = "vol_layout",
                layout = wibox.layout.fixed.horizontal
            },
            id = "container",
            margins = dpi(6),
            widget = wibox.container.margin
        },

        buttons = {
            awful.button({}, 1, function() awful.spawn("pavucontrol") end),
            awful.button({}, 3,
                         function()
                awful.spawn("pulseaudio-equalizer-gtk")
            end)
        },
        bg = beautiful.bar,
        widget = wibox.container.background
    }

    awesome.connect_signal("signal::volume", function(vol, mute)

        volume.container.vol_layout.value.markup =
            "<span foreground='" .. beautiful.orange .. "'>" .. vol ..
                "%</span>"

        if mute or vol == 0 then
            volume.container.vol_layout.vol_icon.markup =
                "<span foreground='" .. beautiful.orange .. "'> </span>"
        else
            if tonumber(vol) > 50 then
                volume.container.vol_layout.vol_icon.markup =
                    "<span foreground='" .. beautiful.orange .. "'>a</span>"
            elseif tonumber(vol) >= 1 then
                volume.container.vol_layout.vol_icon.markup =
                    "<span foreground='" .. beautiful.orange .. "'> </span>"
            else
                -- '> </
                volume.container.vol_layout.vol_icon.markup =
                    "<span foreground='" .. beautiful.orange .. "'> </span>"
            end
        end
    end)

    -- Brightness 

    local bright = wibox.widget {
        {
            {
                {
                    id = "bri_icon",
                    font = beautiful.icon_font,
                    markup = "<span foreground='" .. beautiful.orange ..
                        "'></span>",
                    widget = wibox.widget.textbox
                },
                {
                    id = "value",
                    markup = "<span foreground='" .. beautiful.yellow ..
                        "'> </span>",
                    widget = wibox.widget.textbox
                },
                id = "bri_layout",
                spacing = dpi(4),
                layout = wibox.layout.fixed.horizontal
            },
            id = "container",
            margins = dpi(6),
            widget = wibox.container.margin
        },
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 5) end,
        bg = beautiful.bar,
        widget = wibox.container.background
    }

    awesome.connect_signal("signal::brightness", function(bri)

        _ = tostring(bri)
        bri_val = _:match("(%d+)[.]")

        bright.container.bri_layout.value.markup =
            "<span foreground='" .. beautiful.orange .. "'>" .. bri_val ..
                "%</span>"

        bright.container.bri_layout.bri_icon.markup =
            "<span foreground='" .. beautiful.orange .. "'>  </span>"
    end)

    -- Wifi

    local wifi = wibox.widget {

        {
            {
                {
                    id = "wifi_icon",
                    font = beautiful.icon_font,
                    markup = "<span foreground='" .. beautiful.red ..
                        "'> </span>",
                    widget = wibox.widget.textbox
                },
                {
                    id = "ssid",
                    markup = "<span foreground='" .. beautiful.red ..
                        "'>   </span>",
                    widget = wibox.widget.textbox
                },
                spacing = dpi(4),
                id = "wifi_layout",
                layout = wibox.layout.fixed.horizontal
            },
            id = "container",
            margins = dpi(6),
            widget = wibox.container.margin
        },
        -- shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,5) end,
        buttons = {
            awful.button({}, 1, function()
                awful.spawn("alacritty -e nmtui")
            end)
        },
        bg = beautiful.bar,
        widget = wibox.container.background
    }

    -- Connect signal named "signal::wifi"
    awesome.connect_signal("signal::wifi", function(stat, ssid)

        net_ssid = ssid:match(".[^:]+")

        if not stat then
            wifi.container.wifi_layout.wifi_icon.markup =
                "<span foreground='" .. beautiful.orange .. "'> </span>"
            wifi.container.wifi_layout.ssid.markup =
                "<span foreground='" .. beautiful.orange .. "'>" .. net_ssid ..
                    "</span>"
        else
            wifi.container.wifi_layout.wifi_icon.markup =
                "<span foreground='" .. beautiful.orange .. "'> </span>"
            wifi.container.wifi_layout.ssid.markup =
                "<span foreground='" .. beautiful.orange .. "'>" .. net_ssid ..
                    "</span>"
        end
    end)

    -- Taglist/Workspaces

    local taglist_buttons = gears.table.join(
                                awful.button({}, 1,
                                             function(t) t:view_only() end),
                                awful.button({modkey}, 1, function(t)
            if client.focus then client.focus:move_to_tag(t) end
        end), awful.button({}, 3, awful.tag.viewtoggle),
                                awful.button({modkey}, 3, function(t)
            if client.focus then client.focus:toggle_tag(t) end
        end), awful.button({}, 4, function(t)
            awful.tag.viewnext(t.screen)
        end), awful.button({}, 5, function(t)
            awful.tag.viewprev(t.screen)
        end))

    local tags = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        layout = {spacing = dpi(0), layout = wibox.layout.fixed.horizontal},
        style = {font = beautiful.icon_font},
        buttons = taglist_buttons,
        widget_template = {
            {
                {
                    {
                        id = 'tag',
                        forced_width = dpi(25),
                        align = 'center',
                        widget = wibox.widget.textbox
                    },
                    layout = wibox.layout.align.horizontal
                },
                margins = dpi(4),
                widget = wibox.container.margin
            },
            id = 'container',
            widget = wibox.container.background,
            create_callback = function(self, c3, _) -- Launch this callback when first created it

                if c3.selected then
                    self:get_children_by_id('tag')[1].markup =
                        "<span foreground='" .. beautiful.orange ..
                            "'></span>"
                elseif #c3:clients() == 0 then
                    self:get_children_by_id('tag')[1].markup =
                        "<span foreground='" .. beautiful.taglist_fg_empty ..
                            "'></span>"
                else
                    self:get_children_by_id('tag')[1].markup =
                        "<span foreground='" .. beautiful.blue .. "'></span>"
                end

            end,
            update_callback = function(self, c3, _) -- Update this callback when things changed ig....

                if c3.selected then
                    self:get_children_by_id('tag')[1].markup =
                        "<span foreground='" .. beautiful.orange ..
                            "'></span>"
                elseif #c3:clients() == 0 then
                    self:get_children_by_id('tag')[1].markup =
                        "<span foreground='" .. beautiful.taglist_fg_empty ..
                            "'></span>"
                else
                    self:get_children_by_id('tag')[1].markup =
                        "<span foreground='" .. beautiful.blue .. "'></span>"
                end
            end
        }

    }

    local tag = wibox.widget {
        {
            {tags, layout = wibox.layout.fixed.horizontal},
            margins = {left = dpi(4), right = dpi(4)},
            widget = wibox.container.margin
        },
        bg = beautiful.bar,
        widget = wibox.container.background
    }

    ----- Set up the BAR -----

    s.bar = awful.wibar {
        border_width = 2,
        border_color = beautiful.orange2,
        position = 'top',
        width = s.geometry.width,
        height = dpi(42),
        screen = s,
        bg = beautiful.bar,
        visible = true,
        stretch = true,
        type = dock,
        margins = {top = dpi(10), left = dpi(20), right = dpi(20)}
        -- shape = function(cr,w,h) gears.shape.rounded_bar(cr,w,h) end,
    }

    s.bar:setup{
        { --
            {
                launcher,
                tag,
                spacing = dpi(10),
                layout = wibox.layout.fixed.horizontal
            },

            {
                time,
                spotify_widget({
                    main_color = beautiful.orange,
                    bg_color = beautiful.fg,
                    font = "JetBrainsMono Semibold 9",
                    max_length = 50,
                    dim_when_paused = true,
                    dim_opacity = 0.5,
                    play_icon = gfs.get_configuration_dir() ..
                        "themes/hyphen.png",
                    pause_icon = gfs.get_configuration_dir() ..
                        "themes/hyphen.png"
                }),
                spacing = dpi(10),
                layout = wibox.layout.fixed.horizontal,
                placement = centered_horizontal
            },

            {

                wifi,
                volume,
                bright,
                batteryarc_widget({
                    charging_color = beautiful.transparent,
                    low_level_color = beautiful.transparent,
                    medium_level_color = beautiful.transparent,
                    arc_thickness = 2,
                    show_current_level = true,
                    size = 22,
                    main_color = beautiful.orange,
                    font = "JetBrainsMono Semibold 7",
                    bg_color = beautiful.orange

                }),
                spacing = dpi(15),
                layout = wibox.layout.fixed.horizontal
            },
            layout = wibox.layout.align.horizontal
        },
        margins = dpi(8),
        widget = wibox.container.margin
    } -- Tips: Read/Write the codes from bottom for :setup or widget_template

    -- s.bar:struts {top = dpi(60)}

end)
