if ! (( $+functions[abbr] )); then
  alias ll="ls -al"
fi

alias ls='eza --icons'                                   # ls
alias l='eza -lbF --git --icons'                         # list, size, type, git
alias ll='eza -lbGF --git --icons'                       # long list
alias ltr='eza -lbGd --git --sort=modified --icons'      # long list, modified date sort
alias llm='eza --all --header --long --sort=modified $eza_params'
alias la="eza -lbhHigUmuSa --git --color-scale --icons"  # all list
alias lx='eza -lbhHigUmuSa@ --git --color-scale --icons' # all + extended list

alias lS='eza -1'               # one column, just names
alias lt='eza --tree --level=2' # tree
alias tldr="tldr --config-path $XDG_CONFIG_HOME/tldr/config.toml"