<h2 align='center'>
  The stars don't look bigger, but they do look brighter...
</h2>

<br>

Fork on [N3k0Ch4n](https://github.com/N3k0Ch4n/) cool af AwesomeWM dotfiles. I twekead it using another palette and some other things for my personal usage. 

The amazing wallpaper I used for this project can be apreciated in it's full glory [in here](https://old.reddit.com/r/vandwellers/comments/elcbri/living_out_of_a_uaz452_buhanka_in_georgia_the/)

---

## The Setup:
- **OS** - Manjaro
- **WM**   - AwesomeWM
- **Term**  - Alacritty
- **Comp**  - Picom
- **Menu/Launcher/Window Switcher** - Rofi
- **Shell** - Zsh+Powerlevel10k+Colorls
- **Browser** - Vivaldi 
---

## August 11 2022 Update: v3.2

- Code is reformatted so it should be easier to read (not necessarilly to comprehend unfortunately).
- Trying stuff with [Streetturtle](https://github.com/streetturtle/awesome-wm-widgets) widgets. Mainly the battery one for laptops.
- Edited neofetch theme using TallJoes fetch as seen on [Chick2D's Neofetch Themes Repo](https://github.com/Chick2D/neofetch-themes).
- Mostly of the bar is now clickable. Makes it easier to change some things on the go and more tweakable (like an equalizer).
- Calendar doesn't shows Saturdays, weird but funny.
---

## How Do I Get this?

For this one in particular you just need to follow (or not, cause why not after all?) the following instructions:

**1. Install the dependencies!**

Pottential dependencies
  - Awesome-git
  - inotify-tools
  - Playerctl
  - Brightnessctl
  - Pulseaudio
  - Network-Manager
  - JetBrains Font (both the official and patched version)
  - Font Awesome (its in the files)
  - Neofetch
  - Zsh
  - Alacritty
  - Betterlockscreen
  - Flameshot
  - Vivaldi
  - Pavucontrol
  - Spicetify

And some others both me and the creator don't remember, for now, just give us some time. 
  
</details>

```sh
sudo pacman -Syu alacritty cava inotify-tools playerctl brightnessctl pulseaudio networkmanager alsa-utils alsa-plugins alsa-firmware xclip base-devel pamixer flameshot vivaldi pipes.sh nm-connection-editor pulseaudio-equalizer-gtk pavucontrol
```

```sh
yay awesome-git nerd-fonts-jetbrains-mono ttf-jetbrains-mono 
```

For specifics like spicetify, its better to follow the official installion guide and then aplying the modifications.

**2. Clone the repo**

```sh
git clone https://github.com/Wallsified/Spacedust.git
cd Spacedust
git submodule init
git submodule update
```

**3. Copy the config inside your config folder, in this case "$HOME/.config/"**

```sh
cp -rf awesome picom neofetch alacritty rofi colorls $HOME/.config/
cp -rf .zshrc $HOME/
```

**4. Unzip the theme an apply it to Vivaldi.**

**5. To install the VSCode/Codium theme to go along with the files do:**

```sh
vscodium --install-extension spacedust-0.0.1.vsix

```
or 

```sh
code --install-extension spacedust-0.0.1.vsix
```

And then change the settings.json file provided.  

I'm still working on it and understanding how to actually send it to the Visual Studio Code Marketplace but for now it kinda works doin it like that. 

I also did [this repo](https://github.com/Wallsified/Spacedust-VSCode) for the theme itself. Any help is always appreciated c:

---

**6. Install Spicetify the official way with the Dribbblish theme. Then change the provided files.**

**7. For the DuckDuckGo theme, go on Configuration/Themes/Load Settings and write "lettherebespacedust".**

**8. Restart your system & log in with AwesomeWM.**

**9. You're done!**


## Here's how it actually looks like!

<img widht="300px" src="https://github.com/Wallsified/Spacedust/blob/main/.github/Spacedustv3.2_a.png">
<img widht="300px" src="https://github.com/Wallsified/Spacedust/blob/main/.github/Spacedustv3.2_b.png">
<img widht="300px" src="https://github.com/Wallsified/Spacedust/blob/main/.github/Spacedustv3.2_c.png">
<img widht="300px" src="https://github.com/Wallsified/Spacedust/blob/main/.github/Spacedustv3.2_d.png">
<img widht="300px" src="https://github.com/Wallsified/Spacedust/blob/main/.github/Spacedustv3.2_e.png">
<img widht="300px" src="https://github.com/Wallsified/Spacedust/blob/main/.github/Spacedustv3.2_f.png">



---

### Some keybinds.

| Keybinds    | Launches |
| ----------- | -------- |
| Mod + x     | Terminal |
| Mod + z     | Vivalidi |
| Mod + Space | Change Layout  |
| Mod + r     | Rofi Launcher  |
| Mod + q     | Close Window   |
| Mod + s     | Powermenu|
| Mod + Ctrl + n | Un-minimize |
| Mod + F1    | Global Binds Popup  |

---

### Some quick notes...

- If you want to change the programs, check the apps.lua file!
- There's a couple of easter eggs and silly things on what I like. Gotta catch 'em all!
- My neofetch file has some extra variables for my hardware, just for looks mainly, but be sure to edit them so they apply to yours
- The powermenu works better when pressing the keys rather than clicking the buttons. For this use them as follow: 

  | Key         | Does     |
  | ----------- | -------- |
  |  p          | Power off |
  |  r          | System Reboot  |
  |  s          | Suspend   |
  |  q          | Quit AwesomeWm |
  |  l          | System Lock    |

- The cake's still a lie. 

---

## Improvements in the (near I hope) future

- [ ] Notifications enhancement (use dunst maybe?).
- [ ] Code-Cleaning (make it more first-contact-readable).
- [ ] Better Menu (for clicking the awesome button).
- [ ] Find a way the bar actually gets rounded borders.
- [ ] Maybe make a wiki or something so it's better for new-ricers.

---

## Main Inspirations for this Proyect:

- [Gogh-Co Terminal Palletes](https://github.com/Gogh-Co/Gogh)
- [N3k0Ch4n](https://github.com/N3k0Ch4n/)
- [Chris Titus Awesome Theme](https://github.com/ChrisTitusTech/titus-awesome)
- [Catpuccin Community's Rofi Theme](https://github.com/catppuccin/rofi)
- And of course everyone on r/unixporn!

---

## Millions of Thanks to: 

- [Saimoom/Harry](https://github.com/saimoomedits/dotfiles)
- [Elenapan](https://github.com/elenapan/dotfiles)
- [Ner0z](https://github.com/ner0z/dotfiles)
- [unix-parrot](https://github.com/unix-parrot)
- [Rocky_reddit](https://www.reddit.com/user/Rocky_reddit)

<br>

