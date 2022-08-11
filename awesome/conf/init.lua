-- This file works as an index-start (u get the idea right?) for the conf. folder. 
local beautiful = require "beautiful"
local gfs = require "gears.filesystem"

beautiful.init(gfs.get_configuration_dir() .. "themes/theme.lua")

require "conf.layout"
require "conf.binds"
require "conf.rules"
require "conf.client"
require "conf.notifications"
require "conf.startup"
