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

# Turning confirmations on + recursive
alias mv='mv -i'
alias cp='cp -ir'
alias rm='rm -ir'
alias ln='ln -i'

# configs
source ~/.config/fish/conf.d/conf-aliases.fish

# Misc.
#alias ll='ls -Alh'
#alias la='ls -Ah'
#alias lh='ls --format=single-column'
alias mpv='mpv --no-audio-display'
alias exa='exa --icons --color=always --group-directories-first'
alias ls='exa'
alias ll='exa -la'
alias la='exa -a'
alias lh='exa -1'
alias mkdir='mkdir -pv'
alias ..='cd ..'
alias df='df -h'

# mdt envars
export MDT_DIR='/home/kasetonix/.mdt'
export MDT_INBOX='/home/kasetonix/.mdt/todo.md'

alias space='du -sh 2>/dev/null'
alias untar='tar -xzf'
alias pls='doas'
alias vbc='echo (volume)(battery)(clock)'
alias print-ip='ip -br -4 -c addr'

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

# Function for choosing a wallpaper
function choose-bg --description 'Choose a background using rofi -dmenu'
  feh --bg-fill ~/pics/walls/(/bin/ls ~/pics/walls/ | rofi -dmenu) --no-fehbg $argv
end

export LESS_TERMCAP_mb=$(printf '\e[01;32m')        # enter blinking mode
export LESS_TERMCAP_md=$(printf '\e[01;34;5;75m')   # enter double-bright mode
export LESS_TERMCAP_me=$(printf '\e[0m')            # turn off all appearance modes (mb, md, so, us)
export LESS_TERMCAP_so=$(printf '\e[01;36m')        # enter standout mode
export LESS_TERMCAP_se=$(printf '\e[0m')            # leave standout mode
export LESS_TERMCAP_us=$(printf '\e[04;33;5;200m')  # enter underline mode
export LESS_TERMCAP_ue=$(printf '\e[0m')            # leave underline mode
