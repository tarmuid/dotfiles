[[ -r "$ZDOTDIR/options.zsh" ]] && source "$ZDOTDIR/options.zsh"
[[ -r "$ZDOTDIR/functions.zsh" ]] && source "$ZDOTDIR/functions.zsh"
[[ -r "$ZDOTDIR/keybinds.zsh" ]] && source "$ZDOTDIR/keybinds.zsh"
[[ -r "$ZDOTDIR/aliases.zsh" ]] && source "$ZDOTDIR/aliases.zsh"

autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
