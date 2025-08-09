# Environment variables
EDITOR="nvim"
VISUAL="nvim"
RANGER_LOAD_DEFAULT_RC="false"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#444b6a"

# FZF default options
fzf_default_opts+=(
    "--info=inline"
    "--border=rounded"
    "--height=50%"
    "--multi"
    "--prompt='⊳ '"
    "--pointer='➜ '"
    "--marker=''"
    "--color='hl:cyan,hl+:blue,bg+:-1,pointer:cyan,marker:red,gutter:-1'"
) export FZF_DEFAULT_OPTS=$(printf '%s\n' "${fzf_default_opts[@]}")
