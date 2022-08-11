-- We define our default apps in here. Later we ill use this in the keybind section.  
return {
    default = {
        terminal = 'alacritty',
        rofi = 'rofi -show drun',
        lock = 'betterlockscreen -l',
        screenshot = 'flameshot gui',
        browser = 'vivaldi-stable',
        editor = 'gedit',
        social = 'telegram',
        files = 'thunar',
        mail = 'thunderbird',
        code = 'vscodium',
        calculator = 'gnome-calculator'
    },

    -- Here we define what we want to launch in our startup. It can be bash scripts, maybe an xrandr thing, pick your poison. 
    -- This is what the "run_on_startup" on startup.lua will detect to launch.  
    run_on_start_up = {
        'picom --config ~/.config/picom/picom.conf', 'numlockx on' -- enable numlock at startup
    }
}
