-- The rc.lua file is what actually launches Awesome. Sure, you could just drop all your tweaks in here
-- but that would be messy. That's why we use the "init" files in each folder. Then, we just call them in 
-- here and voilá! 
local gears = require('gears')
package.loaded["awful.hotkeys_popup.keys.tmux"] = {}, -- for removing tmux stuff in the hotkeys popup

                                                  require "signals.init"
require "conf.init"
require "ui.init"
