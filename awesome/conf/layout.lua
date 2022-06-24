local awful = require "awful"
local l = awful.layout.suit

awful.layout.layouts = {
	l.tile,
	l.tile.bottom,
	l.tile.top,
	l.tile.left,
	--l.corner.nw,
}
