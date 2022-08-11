local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local gfs = require("gears.filesystem")
require("awful.autofocus")
local hotkeys_popup = require("awful.hotkeys_popup")
----- Menu -----

multimedia_menu = {{"Spotify", "spotify"}, {"VLC Player", "vlc"}}

development_menu = {
    {"VSCodium", "vscodium"}, {"Gedit", "gedit"}, {"Netbeans", "netbeans"}
}

internet_menu = {
    {"Vivaldi", "vivaldi-stable"}, {"Firefox", "firefox"},
    {"QBitorrent", "qbittorrent"}
}

utilities_menu = {
    {"Calculator", "gnome-calculator"}, {"Teamviewer", "teamviewer"},
    {"Flameshot", "flameshot gui"}, {"File Explorer", "thunar"}
}

awesome_menu = {
    {"Restart WM", awesome.restart}, {"End Session", awesome.quit},
    {"Shutdown", "shutdown now"}, {"Reboot", "reboot now"},
    {"Screen Lock", "betterlockscreen -l"}, {"Suspend", "~/sleep.zsh"}
}

apps_menu = {
    {"Internet", internet_menu}, {"Utilities", utilities_menu},
    {"Multimedia", multimedia_menu}, {"Development", development_menu}
}

mainmenu = awful.menu({
    items = {
        {"Apps", apps_menu}, {"AwesomeWM", awesome_menu, "Awe"},
        {"Terminal", "alacritty"},
        {"Powermenu", function()
            awesome.emit_signal("ui::powermenu:open")
        end}
    }
})

