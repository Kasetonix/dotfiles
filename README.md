# There is **New** README in progress - check out README-WIP.md
# Dotfiles
**This repo contains most of my own dotfiles files - most important ones.**

## Alacritty install
**GitHub Page:**
*https://github.com/alacritty/alacritty*

Dependencies: 

`sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3`


Cloning the source code:

`git clone https://github.com/alacritty/alacritty.git`

`cd alacritty`

Building:

`cd alacritty`

`cargo build --release`

## Fonts
You just have to place fonts in ~/.fonts folder (you may have to create it).

## htop install
**htop Website:**
*https://htop.dev/*

htop is in most distro's repositories

`sudo apt-get install htop`

## i3 install
**GitHub Page:**
*https://github.com/Airblader/i3*

**i3-gaps Github Page:**
*https://github.com/Airblader/i3*

**Base i3 install**

`sudo /usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2021.02.02_all.deb keyring.deb SHA256:cccfb1dd7d6b1b6a137bb96ea5b5eef18a0a4a6df1d6c0c37832025d2edaa710`

`sudo dpkg -i ./keyring.deb`

`echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" >> /etc/apt/sources.list.d/sur5r-i3.list`

`sudo apt update`

`sudo apt install i3`

**i3-gaps install**

i3-gaps is a fork giving you option to have gaps around windows, which I use in my config

`sudo add-apt-repository ppa:kgilmer/speed-ricer`

`sudo apt update`

`sudo apt install i3-gaps-wm`

## Neofetch install
**GitHub page:**
*https://github.com/dylanaraps/neofetch*

Neofetch is in most distro's repositories as well

`sudo apt-get install neofetch`

## Polybar install
**GitHub Page:**
*https://github.com/polybar/polybar*

if you already added ppa from i3-gaps installation instructions you can just install it using apt:

`sudo apt install polybar`

if not, here's the command:

`sudo add-apt-repository ppa:kgilmer/spped-ricer`

## qutebrowser install
**Official Website:**
*https://qutebrowser.org*

**GitHub Page:**
*https://github.com/qutebrowser/qutebrowser*

qutebrowser is already in official Ubuntu repositories, you just have to install it:

`sudo apt install qutebrowser`

It's a really old version, so you probably don't want to use it.

Instead you want to download the source code and compile it

## rofi install
**GitHub Page:**
*https://github.com/davatorium/rofi*

rofi is in official Ubuntu repos as well:

`sudo apt-get install rofi`

## Spicetify install
**GitHub Page:**
*https://github.com/khanhas/spicetify-cli*

To install spicetify, you just have to use following command:

`curl -fsSL https://raw.githubusercontent.com/khanhas/spicetify-cli/master/install.sh | sh`

move my dotfiles folder into ~/.config/spicetify/ and execute these two commands:

`sudo chmod a+wr /opt/spotify` `sudo chmod a+wr /opt/spotify/Apps -R` and execute `spicetify backup apply`

## Vim install
**GitHub Page:**
*https://github.com/vim/vim*

**neovim GitHub Page:**
*https://github.com/neovim/neovim*

**SpaceVim Website**
*https://spacevim.org/*

**Vim**

Vim is of course in official repositories for almost every distro:

`sudo apt install vim`

**neovim**

You can also install neovim - a nice fork of vim, which is more open for community:

`sudo apt-get install neovim`

though you run neovim by typing `nvim` instead of `neovim`

**SpaceVim**

SpaceVim is a nice 'modpack' for Vim and neovim that comes with some plugs and nice configuration.

## Zathura install
**Zathura Website:**
*https://pwmt.org/projects/zathura/*

Zathura is in Ubuntu's main repositories

`sudo apt-get install zathura`
