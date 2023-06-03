-- Here we add the layouts we'll use for our windows. Full layouts can be seen in the Awesome Documentation
local awful = require "awful"
local l = awful.layout.suit

awful.layout.layouts = {
    l.tile, l.tile.bottom, l.tile.top, l.tile.left, l.corner.nw
}
