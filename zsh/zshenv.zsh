# Environment variables
EDITOR="nvim"
VISUAL="nvim"
RANGER_LOAD_DEFAULT_RC="false"
PAGER="bat"

# FZF default options
fzf_default_opts+=(
    "--info=inline"
    "--border=rounded"
    "--height=50%"
    "--multi"
    "--prompt='> '"
    "--pointer='▶'"
    "--marker='✓'"
    "--color='hl:cyan,hl+:blue,bg+:black,pointer:cyan,marker:red,gutter:black'"
) export FZF_DEFAULT_OPTS=$(printf '%s\n' "${fzf_default_opts[@]}")
