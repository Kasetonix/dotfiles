# ███████╗███████╗██╗  ██╗
# ╚══███╔╝██╔════╝██║  ██║
#   ███╔╝ ███████╗███████║
#  ███╔╝  ╚════██║██╔══██║
# ███████╗███████║██║  ██║
# ╚══════╝╚══════╝╚═╝  ╚═╝

# Setting up history
HISTFILE=~/.config/zsh/.zsh-history
HISTSIZE=10000
SAVEHIST=10000

setopt autocd nomatch notify
unsetopt beep # turning the beep off
stty stop undef # disabling ctrl-s stopping the terminal 

# PATH
path+=("/usr/local/bin")
path+=("/usr/local/lib")
path+=("/usr/sbin")
path+=("$HOME/.local/bin")
path+=("$HOME/.scripts")
export PATH

# Prompt
autoload -U colors && colors
PS1="%{$fg_bold[green]%}%~ %{$fg_bold[cyan]%}➜ %{$reset_color%}%{$fg_bold[white]%}"
PS2="%{$fg_bold[cyan]%}> %{$reset_color%}%{$fg_bold[white]%}"
preexec() { printf "\e[0m"; } # resetting the formatting before the command executes

# Sourcing configs
source "$ZDOTDIR/source-functions.zsh"
source-file "aliases.zsh"
source-file "conf-aliases.zsh"
source-file "functions.zsh"
source-file "completion.zsh"

# Sourcing git plugins 
source-plugin "zsh-users/zsh-autosuggestions" # Autocompletion
source-plugin "zsh-users/zsh-syntax-highlighting" # Syntax highlighting
source-plugin "zsh-users/zsh-history-substring-search" # history search using a given substring
source-plugin "hlissner/zsh-autopair" # Autoclosing brackets

# Sourcing local plugins
source-plugin-local "fzf-history-search.zsh" # searching history or files
source-plugin-local "calc.plugin.zsh" # calculator
