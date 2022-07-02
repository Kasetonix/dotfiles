# Dotfiles

## Here are most of my config files and other files useful for configuration
## **Disclaimer** - Only tested on Ubuntu and Arch based distributions

## Alacritty - Terminal emulator
[GitHub page](https://github.com/alacritty/alacritty)

### Arch
Available in arch repositories - `sudo pacman -S alacritty`

### Debian / Ubuntu

Unfortunately binary for alacritty isn't available on Debian/Ubuntu

**Dependencies**

    apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 rustup gzip

**Cloning the source code**

    git clone https://github.com/alacritty/alacritty.git;
    cd alacritty

**Building**

    cargo build --release

**Post-build**
terminfo

    infocmp alacritty || sudo tic -xe alacritty,alacritty-direct extra/alacritty.info

.desktop file

    sudo cp target/release/alacritty /usr/bin;
    sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg;
    sudo desktop-file-install extra/linux/Alacritty.desktop;
    sudo update-desktop-database

man page

    sudo mkdir -p /usr/local/share/man/man1;
    gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null

## Bash - Shell
put bash/.bashrc file in the home folder

## Desktop files - custom .desktop files for programs
These are my custom made .desktop files for some programs i use (including games) - place them into /usr/share/applications

## Fish - Shell


## Fonts

## Homepage - html and css script for my browser homepage

## Htop - Task manager

## i3wm - Tiling window manager

## Neofetch - fetching program

## Vim & Neovim - Text editors

## Polybar - Bar used mostly in TWMs

## Qutebrowser - Lightweight browser written in Python

## Rofi - Program launcher

## Spicetify-cli - css-loader for spotify client

## Wallpapers

## Zathura - PDF reader

