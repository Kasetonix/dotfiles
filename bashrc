# ██████╗  █████╗ ███████╗██╗  ██╗██████╗  ██████╗
# ██╔══██╗██╔══██╗██╔════╝██║  ██║██╔══██╗██╔════╝
# ██████╔╝███████║███████╗███████║██████╔╝██║
# ██╔══██╗██╔══██║╚════██║██╔══██║██╔══██╗██║
# ██████╔╝██║  ██║███████║██║  ██║██║  ██║╚██████╗
# ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝

# /// Exporting /bin to PATH ///
export PATH="/bin:/usr/bin:$PATH" 
# /// History settings ///
HISTCONTROL=ignoreboth
HISTFILESIZE=10000
shopt -s histappend
shopt -s checkwinsize

# /// Prompt ///
PS1='\[\033[01;32m\]\w \[\[\033[0;33m\][\H] \[\[\033[01;36m\]>\[\033[00m\] '
#PS1='\[\033[01;32m\][\w] \[\[\033[0;33m\]\[\[\033[01;36m\]>\[\033[00m\] '
#PS1='\[\033[01;32m\]\w \[\[\033[0;33m\][\H] \[\[\033[01;36m\]→ \[\033[00m\] '
#PS1='\[\033[01;32m\]¯\_(ツ)_/¯\[\033[00m\] '

# /// Enabling color support ///
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias egrep='egrep --color=auto'

# /// Enabling colored GCC warnings and errors ///
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# /// Adding to PATH ///
export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="$HOME/Applications/spicetify-cli:$PATH"
export PATH="$HOME/Applications/pico-8:$PATH"
export PATH="$HOME/Applications/voxatron:$PATH"
export PATH="$HOME/Applications/qutebrowser:$PATH"
export PATH="$HOME/.cargo/bin/:$PATH"
export PATH="$HOME/Applications:$PATH"
export PATH="$HOME/Applications/spicetify-cli:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.scripts/:$PATH"

#  /// Aliases ///
alias ll='ls -Alh'
alias la='ls -Ah'
alias lh='ls --format=single-column'
alias mkdir='mkdir -pv'
alias ..='cd ..'
alias df='df -h'
alias space='du -sh 2>/dev/null'
alias untar='tar -xzf'

# confirmations
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'
alias ln='ln -i'

# configs
alias catpat='cat /home/kasetonix/Documents/GitPAT'

alias conf-i3='$EDITOR ~/.config/i3/config'
alias conf-alacritty='$EDITOR ~/.config/alacritty/alacritty.yml'
alias conf-kitty='$EDITOR ~/.config/kitty/kitty.conf'
alias conf-polybar='$EDITOR ~/.config/polybar/config.ini'
alias conf-bash='$EDITOR ~/.bashrc'
alias conf-vim='$EDITOR ~/.vimrc'
alias conf-nvim='$EDITOR ~/.config/nvim/init.vim'
alias conf-qutebrowser='$EDITOR ~/.config/qutebrowser/config.py'
alias conf-spicetify='cd ~/.config/spicetify'
alias conf-fish='$EDITOR ~/.config/fish/config.fish'
alias conf-neofetch='$EDITOR ~/.config/neofetch/config.conf'
alias conf-zathura='$EDITOR ~/.config/zathura/zathurarc'
alias conf-bspwm='$EDITOR ~/.config/bspwm/bspwmrc'
alias conf-sxhkd='$EDITOR ~/.config/sxhkd/sxhkdrc'
alias conf-picom='$EDITOR ~/.config/picom.conf'
alias conf-dunst='$EDITOR ~/.config/dunst/dunstrc'
alias conf-syncdot='$EDITOR ~/.scripts/syncdot'
alias conf-vis='$EDITOR ~/.config/vis/config'

alias emacs-term='emacs -nw'
alias name='echo $USER/$HOSTNAME'
alias vimtutorshort='less ~/Documents/VIMTutorSummaries.txt'
alias Print='figlet -f /usr/share/figlet/fonts/ansi-shadow.flf'
alias fetch='PF_INFO="ascii title os kernel wm" pfetch'
alias fetch-logo='PF_INFO="ascii" pfetch'
alias bonsai="cbonsai -il"
alias spt="sh /home/kasetonix/.scripts/spt-launch.sh"
alias check-wmclass='xprop | grep "WM_CLASS(STRING)"'
alias matrix='cmatrix -aBs'

# /// Variable Settings ///
export DRI_PRIME=1
export EDITOR='nvim'
export TERM='alacritty'
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US:en'
export LESS='-R'

# Colorful Less Pages
export LESS_TERMCAP_mb=$(printf '\e[01;32m')        # enter blinking            mode
export LESS_TERMCAP_md=$(printf '\e[01;34;5;75m')   # enter double-bright       mode
export LESS_TERMCAP_me=$(printf '\e[0m')            # turn off all appearance   modes (mb, md, so, us)
export LESS_TERMCAP_so=$(printf '\e[01;36m')        # enter standout            mode
export LESS_TERMCAP_se=$(printf '\e[0m')            # leave standout            mode
export LESS_TERMCAP_us=$(printf '\e[04;33;5;200m')  # enter underline           mode
export LESS_TERMCAP_ue=$(printf '\e[0m')            # leave underline

# /// Functions ///
diskspace() {
  echo "TOTAL >$(df -h / --output=size | tail -n 1)"
  echo "USED  >$(df -h / --output=used | tail -n 1)"
  echo "FREE  >$(df -h / --output=avail | tail -n 1)"
  echo "%USED >$(df -h / --output=pcent | tail -n 1)"
}

export diskspace

# /// Autostart ///
#fetch
#fetch-logo | lolcat
#fetch-logo | lolcat -as 240
#Print BASH | lolcat
