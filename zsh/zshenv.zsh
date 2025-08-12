# Environment variables
EDITOR="nvim"
VISUAL="nvim"
RANGER_LOAD_DEFAULT_RC="false"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#444b6a"

# FZF default options
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
    --highlight-line \
    --info=inline \
    --ansi \
    --layout=reverse \
    --border=rounded \
    --height=~50% \
    --multi \
    --prompt='⊳ ' \
    --pointer='➜ ' \
    --marker='·' \
    --color=bg+:-1 \
    --color=bg:-1 \
    --color=border:bright-black \
    --color=fg+:bright-white \
    --color=fg:white \
    --color=gutter:-1 \
    --color=header:yellow \
    --color=hl+:cyan \
    --color=hl:cyan \
    --color=info:yellow \
    --color=marker:red \
    --color=pointer:cyan \
    --color=prompt:cyan \
    --color=separator:bright-black \
    --color=query:bright-white \
    --color=scrollbar:cyan \
    --color=spinner:cyan \
"

# CTRL-Y to copy the command into clipboard using wl-copy
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | wl-copy)+abort'
  --color header:italic"

export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target"

# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"


