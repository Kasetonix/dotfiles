# QoL features
alias ..='cd ..'
alias mkdir='mkdir -pv'
alias mpv='mpv --no-audio-display'
alias df='df -h' # human-readable
alias print-ip='ip -br -4 -c addr'
alias fetch="neofetch"
alias tfetch="neofetch --source /home/kasetonix/.config/neofetch/trans.ascii --gap -20" # :3
alias atfetch="neofetch --source /home/kasetonix/.config/neofetch/arch_trans.ascii --gap -20" # :3
alias mount="doas mount -o dmask=000,fmask=111"
alias umount="doas umount"

# functionality
alias untar='tar -xf'
alias space='du -sh 2>/dev/null'
alias check-wmclass='xprop | grep "WM_CLASS(STRING)"'
alias glow="PAGER='bat --decorations=never --color=always' glow -pa"
alias feh="feh --scale-down"
alias defwall='feh --bg-fill /home/kasetonix/pics/walls/defwall'
alias altwall='feh --bg-fill /home/kasetonix/pics/walls/altwall'
alias fzcd='cd "$(find . -mindepth 1 -type d \( -name ".*" -prune -o -print \) | fzf)"'
alias fzcdh='cd "$(find . -mindepth 1 -type d | fzf)"'
alias up='echo "$fg_bold[green] $reset_color$(checkupdates | wc -l)"'

# git (some of them taken from codingjerk@github)
alias ga='git add -A'
alias gs='git status'
alias gp='git push'
alias gu='git pull'
alias gr='git restore --staged'
alias gcl='git clone'
alias gl="git log --all --graph --pretty=format:'%C(yellow)%h %C(white)| %C(cyan)%an %C(white)| %C(magenta)%ar %C(auto)%D%n%s%n'"

# Turning confirmations on + recursive
alias mv='mv -i'
alias cp='cp -ir'
alias rm='rm -ir'
alias ln='ln -i'

# ls -> eza
alias eza='eza --icons --group-directories-first'
alias ls='eza'
alias ll='eza -la'
alias la='eza -a'
alias lh='eza -1'
alias lt='eza --tree'
