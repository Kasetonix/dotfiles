# https://github.com/junegunn/fzf
# https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh

if 'zmodload' 'zsh/parameter' 2>'/dev/null' && (( ${+options} )); then
  __fzf_key_bindings_options="options=(${(j: :)${(kv)options[@]}})"
else
  () {
    __fzf_key_bindings_options="setopt"
    'local' '__fzf_opt'
    for __fzf_opt in "${(@)${(@f)$(set -o)}%% *}"; do
      if [[ -o "$__fzf_opt" ]]; then
        __fzf_key_bindings_options+=" -o $__fzf_opt"
      else
        __fzf_key_bindings_options+=" +o $__fzf_opt"
      fi
    done
  }
fi

'emulate' 'zsh' '-o' 'no_aliases'

{

[[ -o interactive ]] || return 0

# CTRL-R - Paste the selected command from history into the command line
fzf-history-widget() {
  fzf_history_search_opts+=(
    "--scheme=history"
    "--height=33%"
  ) export FZF_HISTORY_SEARCH_OPTS=$(printf '%s\n' "${fzf_history_search_opts[@]}")

  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  selected=( $(fc -rl 1 | awk '{ cmd=$0; sub(/^[ \t]*[0-9]+\**[ \t]+/, "", cmd); if (!seen[cmd]++) print $0 }' |
    FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS-} ${FZF_HISTORY_SEARCH_OPTS-} --query=${(qqq)LBUFFER}" fzf) )
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle reset-prompt
  return $ret
}

zle     -N            fzf-history-widget
bindkey -M emacs '^R' fzf-history-widget

} always {
  eval $__fzf_key_bindings_options
  'unset' '__fzf_key_bindings_options'
}

# vim: ts=2 sts=2 sw=2 et
