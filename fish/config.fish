# ███████╗██╗███████╗██╗  ██╗
# ██╔════╝██║██╔════╝██║  ██║
# █████╗  ██║███████╗███████║
# ██╔══╝  ██║╚════██║██╔══██║
# ██║     ██║███████║██║  ██║
# ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝

# Coloring
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias egrep='egrep --color=auto'
set GCC_COLORS 'error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# $PATH
set PATH /usr/local/bin /usr/local/lib /usr/sbin $HOME/.emacs.d/bin $HOME/Applications/* $HOME/.local/bin $HOME/.scripts $PATH

# Turning confirmations on
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'
alias ln='ln -i'

# configs
alias catpat='set_color -o yellow; cat /home/kasetonix/docs/gitpat'

alias conf-i3='$EDITOR ~/.config/i3/config'
alias conf-hypr='$EDITOR ~/.config/hypr/hypr.conf'
alias conf-dwm='$EDITOR ~/.dwm/config.def.h'
alias conf-alacritty='$EDITOR ~/.config/alacritty/alacritty.yml'
alias conf-kitty='$EDITOR ~/.config/kitty/kitty.conf'
alias conf-polybar='$EDITOR ~/.config/polybar/config.ini'
alias conf-bash='$EDITOR ~/.bashrc'
abbr -a conf-fish '$EDITOR ~/.config/fish/'
alias conf-vim='$EDITOR ~/.vimrc'
alias conf-nvim='$EDITOR ~/.config/nvim/init.vim'
alias conf-fish='$EDITOR ~/.config/fish/config.fish'
alias conf-neofetch='$EDITOR ~/.config/neofetch/config.conf'
alias conf-zathura='$EDITOR ~/.config/zathura/zathurarc'
alias conf-bspwm='$EDITOR ~/.config/bspwm/bspwmrc'
alias conf-sxhkd='$EDITOR ~/.config/sxhkd/sxhkdrc'
alias conf-picom='$EDITOR ~/.config/picom.conf'
alias conf-dunst='$EDITOR ~/.config/dunst/dunstrc'
alias conf-syncdot='$EDITOR ~/.scripts/syncdot'
alias conf-ncspot='$EDITOR ~/.config/ncspot/config.toml'
alias conf-mpd='$EDITOR ~/.config/mpd/mpd.conf'
alias conf-ncmpcpp='$EDITOR ~/.config/ncmpcpp/'
alias conf-vis='$EDITOR ~/.config/vis/config'

# Misc.
#alias ll='ls -Alh'
#alias la='ls -Ah'
#alias lh='ls --format=single-column'
alias mpv='mpv --no-audio-display'
alias rm='rm -r'
alias exa='exa --icons --color=always --group-directories-first'
alias ls='exa'
alias ll='exa -la'
alias la='exa -a'
alias lh='exa -1'
alias mkdir='mkdir -pv'
alias ..='cd ..'
alias df='df -h'
alias space='du -sh 2>/dev/null'
alias untar='tar -xzf'
alias pls='doas'
alias vbc='echo (volume)(battery)(clock)'

alias emacs-term='emacs -nw'
alias name='echo (set_color -o yellow)$USER(set_color -o blue)@(set_color -o green)$hostname(set_color white)'
alias glg='git log --oneline --graph --decorate'
alias vimtutorshort='bat ~/Documents/VIMTutorSummaries.txt'
alias Print='figlet -f /usr/share/figlet/fonts/ansi-shadow.flf'
#alias fetch='PF_INFO="ascii title os kernel wm" pfetch'
#alias fetch-logo='PF_INFO="ascii" pfetch'
alias fetch="neofetch"
alias bonsai="cbonsai -il"
alias spt="sh /home/kasetonix/.scripts/spt-launch.sh"
alias check-wmclass='xprop | grep "WM_CLASS(STRING)"'
#alias matrix='cmatrix -aBs'
alias matrix='unimatrix -b -s 90 -l o -a'
alias aesth='feh --bg-fill /home/kasetonix/pics/walls/Aesthetically-pleasing.jpg'
alias defwall='feh --bg-fill /home/kasetonix/pics/walls/Singles.jpg'
