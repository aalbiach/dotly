dot-widget() {
  "$DOTLY_PATH/bin/dot"
  # Redraw the prompt after fzf exits so zle doesn't look hung
  zle reset-prompt
}

zle -N dot-widget
bindkey '^f' dot-widget
