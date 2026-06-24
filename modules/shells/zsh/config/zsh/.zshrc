[[ -r "$ZDOTDIR/options.zsh" ]] && source "$ZDOTDIR/options.zsh"
[[ -r "$ZDOTDIR/functions.zsh" ]] && source "$ZDOTDIR/functions.zsh"
[[ -r "$ZDOTDIR/aliases.zsh" ]] && source "$ZDOTDIR/aliases.zsh"
[[ -r "$ZDOTDIR/zimfw.zsh" ]] && source "$ZDOTDIR/zimfw.zsh"
[[ -r "$ZDOTDIR/keybinds.zsh" ]] && source "$ZDOTDIR/keybinds.zsh"

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi
[[ -r "$ZDOTDIR/starship.zsh" ]] && source "$ZDOTDIR/starship.zsh"
