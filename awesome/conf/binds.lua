-- So, in this file is where we add all the keybinds we'll use in the window manager. 
-- For the keyboard bindings, the default function goes like this: 
-- awful.key({ possible_mod_key }, "key", function () awful.spawn(program.to.spawn) end, {description = "Program for Something", group = "Program Group"}),  
-- Note that depending on what we need to launch, is the function we'll need. 
local awful = require "awful"
local hotkeys = require("awful.hotkeys_popup")
local beautiful = require "beautiful"
local gears = require "gears"
local dpi = beautiful.xresources.apply_dpi
-- We add the apps "module" so we can call the default programs. 
local apps = require "conf.apps"

-- New HotKeys Widget for some tweaking

local test_hkwidget = hotkeys.widget.new({
    hide_without_description = true,
    merge_duplicates = true,
    shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, dpi(20)) end
})

-- For Better reading on main keys

modkey = "Mod4"
alt = "Mod1"

-- Although you could add all keybinds in a parenthesis, is bettter to section them in function on what they do, so you can later find groups and so on easier. 

-- Aplications (remember apps.lua? Here we apply them. )

awful.keyboard.append_global_keybindings({
    awful.key({modkey}, "x", function() awful.spawn(apps.default.terminal) end,
              {description = "Terminal", group = "Applications"}),
    awful.key({modkey}, "r", function() awful.spawn(apps.default.rofi) end,
              {description = "Rofi Menu", group = "Applications"}),
    awful.key({modkey}, "z", function() awful.spawn(apps.default.browser) end,
              {description = "Vivaldi Browser", group = "Applications"}),
    awful.key({modkey}, "e", function() awful.spawn(apps.default.files) end,
              {description = "File Explorer", group = "Applications"}),
    awful.key({modkey}, "c", function() awful.spawn(apps.default.code) end,
              {description = "VsCodium", group = "Applications"}),
    awful.key({modkey}, "t", function() awful.spawn(apps.default.mail) end,
              {description = "Mail Client", group = "Applications"}),
    awful.key({modkey, "Shift"}, "c",
              function() awful.spawn(apps.default.calculator) end,
              {description = "Calculator", group = "Applications"}),
    awful.key({modkey}, "a", function() awful.spawn(apps.default.arduino) end,
              {description = "Arduino IDE", group = "Applications"})
})

-- Tags / Workspaces related keybindings

awful.keyboard.append_global_keybindings({
    awful.key({modkey}, "Left", awful.tag.viewprev, {
        description = "View Previous Workspace",
        group = "Workspace Manipulation"
    }), awful.key({modkey}, "Right", awful.tag.viewnext, {
        description = "View Next Workspace",
        group = "Workspace Manipulation"
    }), awful.key({modkey}, "Escape", awful.tag.history.restore,
                  {description = "go back", group = "Workspace Manipulation"}),
    -- Show Desktop / Minimize everything for a bit          
    awful.key({modkey}, "d", function(c)
        if show_desktop then
            for _, c in ipairs(client.get()) do
                c:emit_signal("request::activate", "key.unminimize",
                              {raise = true})
            end
            show_desktop = false
        else
            for _, c in ipairs(client.get()) do c.minimized = true end
            show_desktop = true
        end
    end, {
        description = "Toggle Showing the Desktop",
        group = "Window Manipulation"
    })
})

-- Focus related keybindings

awful.keyboard.append_global_keybindings({
    awful.key({modkey}, "j", function() awful.client.focus.byidx(1) end, {
        description = "Focus Next by Index",
        group = "Window Manipulation"
    }), awful.key({modkey}, "k", function() awful.client.focus.byidx(-1) end, {
        description = "Focus Previous by Index",
        group = "Window Manipulation"
    }), awful.key({modkey}, "Tab", function()
        awful.client.focus.history.previous()
        if client.focus then client.focus:raise() end
    end, {description = "Go back", group = "Window Manipulation"}),
    awful.key({modkey, "Control"}, "j",
              function() awful.screen.focus_relative(1) end, {
        description = "Focus the Next Screen",
        group = "Screen Manipulation"
    }), awful.key({modkey, "Control"}, "k",
                  function() awful.screen.focus_relative(-1) end, {
        description = "Focus the Previous Screen",
        group = "Screen Manipulation"
    }), -- Focus restored client
    awful.key({modkey, "Control"}, "n", function()
        local c = awful.client.restore()
        if c then c:activate{raise = true, context = "key.unminimize"} end
    end, {description = "Restore Minimized", group = "Window Manipulation"})
})

-- Layout related keybindings

awful.keyboard.append_global_keybindings({
    awful.key({modkey, "Shift"}, "j", function() awful.client.swap.byidx(1) end,
              {
        description = "Swap with Next Window by Index",
        group = "Window Manipulation"
    }),
    awful.key({modkey, "Shift"}, "k",
              function() awful.client.swap.byidx(-1) end, {
        description = "Swap with Previous Window by Index",
        group = "Window Manipulation"
    }), awful.key({modkey}, "u", awful.client.urgent.jumpto, {
        description = "Jump to Urgent Window",
        group = "Window Manipulation"
    }), awful.key({modkey}, "l", function() awful.tag.incmwfact(0.05) end, {
        description = "Increase Master Width Factor",
        group = "Layout Manipulation"
    }), awful.key({modkey}, "h", function() awful.tag.incmwfact(-0.05) end, {
        description = "Decrease Master Width Factor",
        group = "Layout Manipulation"
    }), awful.key({modkey, "Shift"}, "h",
                  function() awful.tag.incnmaster(1, nil, true) end, {
        description = "Increase the Number of Master Windows/Clients",
        group = "Layout Manipulation"
    }), awful.key({modkey, "Shift"}, "l",
                  function() awful.tag.incnmaster(-1, nil, true) end, {
        description = "Decrease the Number of Master Windows/Clients",
        group = "Layout Manipulation"
    }), awful.key({modkey, "Control"}, "h",
                  function() awful.tag.incncol(1, nil, true) end, {
        description = "Increase the Number of Columns",
        group = "Layout Manipulation"
    }), awful.key({modkey, "Control"}, "l",
                  function() awful.tag.incncol(-1, nil, true) end, {
        description = "Decrease the Number of Columns",
        group = "Layout Manipulation"
    }), awful.key({modkey}, "space", function() awful.layout.inc(1) end, {
        description = "Select Next Layout",
        group = "Layout Manipulation"
    }),
    awful.key({modkey, "Shift"}, "space", function() awful.layout.inc(-1) end, {
        description = "Select Previous Layout",
        group = "Layout Manipulation"
    })
})

-- Volume. Repeated keys are for usage on any keyboard layout and not depending on what Fn+x does. 

awful.keyboard.append_global_keybindings({
    awful.key({}, "XF86AudioRaiseVolume",
              function() awful.spawn.with_shell("pamixer -i 5") end,
              {description = "Volume Up", group = "Media Control"}),
    awful.key({"Shift"}, "F3",
              function() awful.spawn.with_shell("pamixer -i 5") end,
              {description = "Volume Up", group = "Media Control"}),
    awful.key({}, "XF86AudioLowerVolume",
              function() awful.spawn.with_shell("pamixer -d 5") end,
              {description = "Volume Down", group = "Media Control"}),
    awful.key({"Shift"}, "F2",
              function() awful.spawn.with_shell("pamixer -d 5") end,
              {description = "Volume Down", group = "Media Control"}),
    awful.key({}, "XF86AudioMute",
              function() awful.spawn.with_shell("pamixer -t") end,
              {description = "Mute / Unmute", group = "Media Control"}),
    awful.key({"Shift"}, "F1",
              function() awful.spawn.with_shell("pamixer -t") end,
              {description = "Mute / Unmute", group = "Media Control"}),
    awful.key({}, "XF86AudioPlay",
              function() awful.spawn.with_shell("playerctl play-pause") end,
              {description = "Play / Pause", group = "Media Control"}),
    awful.key({"Shift"}, "F9",
              function() awful.spawn.with_shell("playerctl play-pause") end,
              {description = "Play / Pause", group = "Media Control"}),
    awful.key({}, "XF86AudioNext",
              function() awful.spawn.with_shell("playerctl next") end,
              {description = "Next", group = "Media Control"}),
    awful.key({"Shift"}, "F10",
              function() awful.spawn.with_shell("playerctl next") end,
              {description = "Next", group = "Media Control"}),
    awful.key({}, "XF86AudioPrev",
              function() awful.spawn.with_shell("playerctl previous") end,
              {description = "Previous", group = "Media Control"}),
    awful.key({"Shift"}, "F11",
              function() awful.spawn.with_shell("playerctl previous") end,
              {description = "Previous", group = "Media Control"}),
    awful.key({}, "XF86AudioStop",
              function() awful.spawn.with_shell("playerctl stop") end,
              {description = "Stop", group = "Media Control"}),
    awful.key({"Shift"}, "F12",
              function() awful.spawn.with_shell("playerctl stop") end,
              {description = "Stop", group = "Media Control"})
})

-- Brightness. Repeated keys are for usage on any keyboard layout, and not depending on what Fn+x does, again. 

awful.keyboard.append_global_keybindings({
    awful.key({}, "XF86MonBrightnessUp",
              function() awful.spawn.with_shell("brightnessctl set 5%+") end, {
        description = "Increase Brightness",
        group = "Brightness Control"
    }), awful.key({}, "XF86MonBrightnessDown", function()
        awful.spawn.with_shell("brightnessctl set 5%-")
    end, {description = "Decrease Brightness", group = "Brightness Control"}),
    awful.key({alt}, "F11",
              function() awful.spawn.with_shell("brightnessctl set 5%-") end, {
        description = "Increase Brightness",
        group = "Brightness Control"
    }), awful.key({alt}, "F12", function()
        awful.spawn.with_shell("brightnessctl set 5%+")
    end, {description = "Decrease Brightness", group = "Brightness Control"})
})

-- Systen Utilities

awful.keyboard.append_global_keybindings({
    awful.key({modkey}, "F1", function() test_hkwidget:show_help() end, nil,
              {description = "Show Help", group = "System Utilities"}),
    awful.key({modkey}, "F10", function() awful.spawn.with_shell("reboot") end,
              {description = "Reboot System", group = "System Utilities"}),
    awful.key({modkey}, "F12", awesome.restart,
              {description = "Reboot AwesomeWm", group = "System Utilities"}),
    awful.key({modkey, "Shift"}, "q", awesome.quit,
              {description = "Quit Session", group = "System Utilities"}),
    awful.key({modkey}, "F11",
              function() awful.spawn.with_shell("shutdown now") end,
              {description = "System Shutdown", group = "System Utilities"}),
    awful.key({modkey}, "w", function()
        awful.spawn.with_shell("playerctl play-pause && betterlockscreen -l")
    end, {description = "Lock", group = "System Utilities"}),
    awful.key({modkey}, "s",
              function() awesome.emit_signal("ui::powermenu:open") end,
              {description = "Power Menu", group = "System Utilities"})

})

awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers = {modkey},
        keygroup = "numrow",
        description = "Change Workspace by Number",
        group = "Workspace Manipulation",
        on_press = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then tag:view_only() end
        end
    }, -- awful.key {
    --  modifiers   = { modkey, "Control" },
    -- keygroup    = "numrow",
    -- description = "toggle tag",
    -- group       = "tag",
    -- on_press    = function (index)
    --  local screen = awful.screen.focused()
    -- local tag = screen.tags[index]
    -- if tag then
    --   awful.tag.viewtoggle(tag)
    -- end
    -- end,
    -- },
    awful.key {
        modifiers = {modkey, "Shift"},
        keygroup = "numrow",
        description = "Move Focused Window to Workspace by Number",
        group = "Window Manipulation",
        on_press = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then client.focus:move_to_tag(tag) end
            end
        end
    }, -- awful.key {
    --  modifiers   = { modkey, "Control", "Shift" },
    -- keygroup    = "numrow",
    -- description = "toggle focused client on tag",
    -- group       = "tag",
    -- on_press    = function (index)
    --  if client.focus then
    --    local tag = client.focus.screen.tags[index]
    --  if tag then
    --    client.focus:toggle_tag(tag)
    -- end
    -- end
    -- end,
    -- },
    awful.key {
        modifiers = {modkey},
        keygroup = "numpad",
        description = "Select Layout Directly (w/Numpad)",
        group = "Layout Manipulation",
        on_press = function(index)
            local t = awful.screen.focused().selected_tag
            if t then t.layout = t.layouts[index] or t.layout end
        end
    }
})

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key({modkey}, "f", function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end, {description = "Toggle fullscreen", group = "Window Manipulation"}),
        awful.key({modkey}, "q", function(c) c:kill() end,
                  {description = "Close", group = "Window Manipulation"}),
        awful.key({modkey, "Control"}, "space", awful.client.floating.toggle, {
            description = "Toggle Floating",
            group = "Window Manipulation"
        }), awful.key({modkey, "Control"}, "Return",
                      function(c) c:swap(awful.client.getmaster()) end, {
            description = "Move to Master",
            group = "Window Manipulation"
        }), awful.key({modkey}, "o", function(c) c:move_to_screen() end, {
            description = "Move To Next Monitor",
            group = "Screen Manipulation"
        }), awful.key({modkey}, "t", function(c) c.ontop = not c.ontop end, {
            description = "toggle keep on top",
            group = "Window Manipulation"
        }),
        -- The client currently has the input focus, so it cannot be minimized, since minimized clients can't have the focus.
        awful.key({modkey}, "n", function(c) c.minimized = true end, {
            description = "Minimize Window",
            group = "Window Manipulation"
        }), awful.key({modkey}, "m", function(c)
            c.maximized = not c.maximized
            c:raise()
        end, {
            description = "(Un)Maximize Window",
            group = "Window Manipulation"
        }), awful.key({modkey, "Control"}, "m", function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end, {
            description = "(Un)Maximize Vertically",
            group = "Window Manipulation"
        }), awful.key({modkey, "Shift"}, "m", function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end, {
            description = "(Un)Maximize horizontally",
            group = "Window Manipulation"
        })
    })
end)

-- Mouse bindings. These work in a special way, mainly for the buttons. Button 1 on your mouse is standard click (left by default), button 3 is right-click. 
-- Depending on how many buttons your mouse has you can use them in your favour for the window manager. 

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({}, 1, function(c)
            c:activate{context = "mouse_click"}
        end), awful.button({modkey}, 1, function(c)
            c:activate{context = "mouse_click", action = "mouse_move"}
        end), awful.button({modkey}, 3, function(c)
            c:activate{context = "mouse_click", action = "mouse_resize"}
        end)
    })
end)

