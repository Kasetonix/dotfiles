# QoL features
alias ..='cd ..'
alias mkdir='mkdir -pv'
alias mpv='mpv --no-audio-display'
alias df='df -h' # human-readable
alias print-ip='ip -br -4 -c addr'
alias fetch="neofetch"
alias mount="doas mount -o dmask=000,fmask=111"
alias umount="doas umount"

# functionality
alias untar='tar -xzf'
alias space='du -sh 2>/dev/null'
alias glg='git log --oneline --graph --decorate'
alias check-wmclass='xprop | grep "WM_CLASS(STRING)"'
alias feh='feh --no-fehbg'
alias defwall='feh --bg-fill /home/kasetonix/pics/walls/defwall'
alias altwall='feh --bg-fill /home/kasetonix/pics/walls/altwall'

# Turning confirmations on + recursive
alias mv='mv -i'
alias cp='cp -ir'
alias rm='rm -ir'
alias ln='ln -i'

# ls -> exa
alias exa='exa --icons --color=always --group-directories-first'
alias ls='exa'
alias ll='exa -la'
alias la='exa -a'
alias lh='exa -1'
alias lt='exa --tree'

# cat / less -> bat
alias bat="bat --theme OneHalfDark"
