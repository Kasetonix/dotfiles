# Completion options
zstyle :compinstall filename "$ZDOTDIR/.zshrc"
zstyle ':completion:*' menu select # Completion menu
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==36=00}:${(s.:.)LS_COLORS}")' # Highlighting

# Loading the completions
autoload -Uz compinit
compinit -d "$ZDOTDIR/.compinit-dump"
_comp_options+=(globdots) # include hidden files
eval "$(register-python-argcomplete pipx)" # pipx completion
