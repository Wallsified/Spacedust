<h2 align='center'>
  The stars don't look bigger, but they do look brighter...
</h2>

<br>

Fork on [N3k0Ch4n](https://github.com/N3k0Ch4n/) cool af AwesomeWM dotfiles. I twekead it using another palette and some other things for my personal usage. 
The amazing wallpaper I used for this project can be apreciated in it's full glory [in here](https://old.reddit.com/r/vandwellers/comments/elcbri/living_out_of_a_uaz452_buhanka_in_georgia_the/)

### The Setup :
- **OS** - Arco Linux
- **WM**   - AwesomeWM
- **Term**  - Alacritty
- **Comp**  - Picom
- **Menu/Launcher/Window Switcher** - Rofi
- **Shell** - Zsh w/ Powerlevel10k
- **Browser** - Vivaldi 
- **Candy Eye** - Cava, Neofetch, Pipes.sh
---

### How Do I Get this?

For this one in particular you just need to follow (or not, cause why not after all?) the following instructions:

**1. Install the dependencies!**

<details close><summary>Pottential dependencies
</summary>
  
  - [awesome-git](https://aur.archlinux.org/packages/awesome-git)
  - inotify-tools
  - playerctl
  - brightnessctl
  - pulseaudio
  - network-manager
  - JetBrains Font
  - neofetch
  - zsh
  - alacritty
  - cava
  - betterlockscreen
  - flameshot
  - Vivaldi
  - [powerlevel10k](https://github.com/romkatv/powerlevel10k)

And some others both me and the creator don't remember, for now, just give us some time. If you want to change the programs, check the apps.lua file!

  
</details>

```sh
sudo pacman -S alacritty cava inotify-tools playerctl brightnessctl pulseaudio networkmanager \
alsa-utils alsa-plugins alsa-firmware xclip base-devel pamixer awesome-git
```

**2. Clone the repo**

```sh
git clone https://github.com/Wallsified/Spacedust.git
cd Spacedust
git submodule init
git submodule update
```

**3. Copy the config inside your config folder, in this case "$HOME/.config/"**

```sh
cp -rf awesome picom neofetch alacritty rofi cava $HOME/.config/
cp -rf .zshrc $HOME/

```
**4. Unzip the theme an apply it to Vivaldi**

**5. Make a snapshot! Just in case**

**6. Restart your system & Log in with AwesomeWM**

**7. You're done!**

---

**Here's how it actually looks like:**

<img widht="300px" src="https://github.com/Wallsified/Spacedust/blob/main/.github/Full_Spacedust.jpg">

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

- There's a couple of easter eggs and silly things on what I like. Gotta catch 'em all!
- My neofetch file has some extra variables for my hardware, just for looks mainly, but be sure to edit them so they apply to yours
- The powermenu works (for now) better when pressing the keys rather than clicking the buttons. For this use them as follow: 

| Key         | Does     |
| ----------- | -------- |
|  p          | Power off |
|  r          | System Reboot  |
|  s          | Suspend   |
|  q          | Quit AwesomeWm |
|  l          | System Lock    |

- The cake's still a lie. 

### Improvements in the (near I hope) future

- [ ] Somehow I screwed the powermenu buttons, fix that.  
- [ ] Notifications enhancement (use dunst maybe?).
- [ ] Code-Cleaning (make it more first-contact-readable).
- [ ] Better Menu (for clicking the awesome button).
- [ ] Adapt the widgets for a better look.
- [ ] Find a way the bar actually gets rounded borders.
- [ ] Maybe make a wiki or something so it's better for new-ricers.
- [ ] VSCode/Codium theme to go with it.

---

## Main Inspirations for this Proyect

- [Gogh-Co Terminal Palletes](https://github.com/Gogh-Co/Gogh)
- [N3k0Ch4n](https://github.com/N3k0Ch4n/)
- [Chris Titus Awesome Theme](https://github.com/ChrisTitusTech/titus-awesome)
- [Catpuccin Community's Rofi Theme](https://github.com/catppuccin/rofi)
- And of course everyone on r/unixporn!

### Millions of Thanks to 

- [Saimoom/Harry](https://github.com/saimoomedits/dotfiles)
- [Elenapan](https://github.com/elenapan/dotfiles)
- [Ner0z](https://github.com/ner0z/dotfiles)
- [unix-parrot](https://github.com/unix-parrot)

<br>

## Keep on Ricing, Act on Instinct!**
