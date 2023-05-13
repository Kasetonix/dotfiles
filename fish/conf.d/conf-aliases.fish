function conf-i3 --description '~/.config/i3/config'
    $EDITOR ~/.config/i3/config $argv
end

function conf-hypr --description '~/.config/hypr/hypr.conf'
    $EDITOR ~/.config/hypr/hypr.conf $argv
end

function conf-dwm --description '~/.dwm/config.def.h'
    $EDITOR ~/.dwm/config.def.h $argv
end

function conf-alacritty --description '~/.config/alacritty/alacritty.yml'
    $EDITOR ~/.config/alacritty/alacritty.yml $argv
end

function conf-kitty --description '~/.config/kitty/kitty.conf'
    $EDITOR ~/.config/kitty/kitty.conf $argv
end

function conf-polybar --description '~/.config/polybar/config.ini'
    $EDITOR ~/.config/polybar/config.ini $argv
end

function conf-bash --description '~/.bashrc'
    $EDITOR ~/.bashrc $argv
end

function conf-fish --description '~/.config/fish/'
    $EDITOR ~/.config/fish/ $argv
end

function conf-vim --description '~/.vimrc'
    $EDITOR ~/.vimrc $argv
end

function conf-nvim --description '~/.config/nvim/init.lua'
    $EDITOR ~/.config/nvim/init.lua $argv
end

function conf-fish --description '~/.config/fish/config.fish'
    $EDITOR ~/.config/fish/config.fish $argv
end

function conf-neofetch --description '~/.config/neofetch/config.conf'
    $EDITOR ~/.config/neofetch/config.conf $argv
end

function conf-zathura --description '~/.config/zathura/zathurarc'
    $EDITOR ~/.config/zathura/zathurarc $argv
end

function conf-bspwm --description '~/.config/bspwm/bspwmrc'
    $EDITOR ~/.config/bspwm/bspwmrc $argv
end

function conf-sxhkd --description '~/.config/sxhkd/sxhkdrc'
    $EDITOR ~/.config/sxhkd/sxhkdrc $argv
end

function conf-picom --description '~/.config/picom.conf'
    $EDITOR ~/.config/picom.conf $argv
end

function conf-dunst --description '~/.config/dunst/dunstrc'
    $EDITOR ~/.config/dunst/dunstrc $argv
end

function conf-syncdot --description '~/.scripts/syncdot'
    $EDITOR ~/.scripts/syncdot $argv
end

function conf-ncspot --description '~/.config/ncspot/config.toml'
    $EDITOR ~/.config/ncspot/config.toml $argv
end

function conf-mpd --description '~/.config/mpd/mpd.conf'
    $EDITOR ~/.config/mpd/mpd.conf $argv
end

function conf-ncmpcpp --description '~/.config/ncmpcpp/'
    $EDITOR ~/.config/ncmpcpp/ $argv
end

function conf-vis --description '~/.config/vis/config'
    $EDITOR ~/.config/vis/config $argv
end

function conf-ranger --description '~/.config/ranger/'
    $EDITOR ~/.config/ranger/ $argv
end

set FPROFILE 'vqxydjgg.kasetonix'
function conf-firefox --description '~/.mozilla/firefox/$PROFILE/chrome'
    $EDITOR ~/.mozilla/firefox/$FPROFILE/chrome $argv
end

function catpat --description 'set_color -o yellow; cat /home/kasetonix/docs/gitpat'
    set_color -o yellow; cat /home/kasetonix/docs/gitpat $argv
end
