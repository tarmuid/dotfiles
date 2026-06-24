bindkey -v

if (( $+widgets[history-substring-search-up] && $+widgets[history-substring-search-down] )); then
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
else
  autoload -Uz up-line-or-beginning-search
  autoload -Uz down-line-or-beginning-search
  zle -N up-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey '^[[A' up-line-or-beginning-search
  bindkey '^[[B' down-line-or-beginning-search
fi

(( $+widgets[autosuggest-accept] )) && bindkey '^ ' autosuggest-accept
