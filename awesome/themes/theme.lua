-- In this file we add the colours and so on of variables that will make our design unique. 
-- There's some names that are restricted for the window manager but you can create your own
-- and later use them globally by using the "beautiful" library built in awesome. 
-- We'll get to that later.  
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local themes_path = gfs.get_configuration_dir() .. "themes/"

local theme = {}

----- Fonts -----

theme.font = "JetBrainsMono Semibold 9"
theme.font_name = "JetBrains Mono Semibold"
theme.font_size = "9"
theme.icon_font = "Font Awesome 6 Free 10"
theme.icon_font_size = "30"

----- Colors -----

theme.blue = "#0f548b"
theme.yellow = "#ff8a3a"
theme.green = "#ff8a3a"
theme.red = "#ff8a3a"
theme.crayola = "#06afc7"
theme.orange = "#ff8a3a"
theme.magenta = "#ff8a3a"
theme.orange2 = "#e35b00"
theme.transparent = "#00000000"
theme.blue_main = "#0a1e24"
theme.blue_second = '#002b36'
theme.white = '#ecf0c1'
theme.gray = "#404B66"

----- General/default Settings -----

theme.bg_normal = theme.blue_main
theme.bg_focus = theme.blue_main
theme.bg_urgent = theme.blue_main
theme.bg_minimize = theme.blue_main
theme.bg_systray = theme.blue_main

theme.fg_normal = "#ff8a3a"
theme.fg_focus = theme.fg_normal
theme.fg_urgent = theme.fg_normal
theme.fg_minimize = theme.fg_normal

theme.useless_gap = dpi(10)

----- Bar -----

theme.bar = theme.blue_main
theme.bar_alt = "#212331"

theme.border_width = dpi(1.8)
theme.border_normal = theme.bg_normal
theme.border_focus = theme.orange2

theme.menu_height = dpi(20)
theme.menu_width = dpi(150)
theme.menu_bg_normal = theme.blue_main

theme.taglist_fg_focus = theme.blue
theme.taglist_fg_occupied = theme.fg_normal
theme.taglist_fg_empty = theme.gray
theme.taglist_bg_focus = theme.blue
theme.tasklist_fg_focus = theme.crayola

theme.titlebar_bg_normal = theme.bar
theme.titlebar_bg_focus = theme.bar

theme.wallpaper = gfs.get_configuration_dir() .. "themes/twilight_spacedust.jpg"

----- HotKeys Widget -----

theme.hotkeys_group_margin = 30
theme.hotkeys_border_color = theme.orange2
theme.hotkeys_border_width = dpi(2)
theme.hotkeys_modifiers_fg = theme.orange2
theme.hotkeys_label_bg = theme.blue_second

theme.notification_margin = 11

----- Awesome Icon -----

theme.awesome_icon = theme_assets.awesome_icon("25", theme.orange, theme.bar)
theme.awesome_mini = theme_assets.awesome_icon("5", theme.orange, theme.bar)

return theme

