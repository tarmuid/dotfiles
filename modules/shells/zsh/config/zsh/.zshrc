[[ -r "$ZDOTDIR/options.zsh" ]] && source "$ZDOTDIR/options.zsh"
[[ -r "$ZDOTDIR/functions.zsh" ]] && source "$ZDOTDIR/functions.zsh"
[[ -r "$ZDOTDIR/aliases.zsh" ]] && source "$ZDOTDIR/aliases.zsh"
[[ -r "$ZDOTDIR/zimfw.zsh" ]] && source "$ZDOTDIR/zimfw.zsh"
[[ -r "$ZDOTDIR/keybinds.zsh" ]] && source "$ZDOTDIR/keybinds.zsh"
[[ -r "$ZDOTDIR/ssh.zsh" ]] && source "$ZDOTDIR/ssh.zsh"

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi
[[ -r "$ZDOTDIR/starship.zsh" ]] && source "$ZDOTDIR/starship.zsh"
[[ -r "$ZDOTDIR/config.d/javascript.zsh" ]] && source "$ZDOTDIR/config.d/javascript.zsh"
[[ -r "$ZDOTDIR/config.d/go.zsh" ]] && source "$ZDOTDIR/config.d/go.zsh"
[[ -r "$ZDOTDIR/config.d/rust.zsh" ]] && source "$ZDOTDIR/config.d/rust.zsh"

if command -v "mise" >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

if command -v "fnox" >/dev/null 2>&1; then
  eval "$(fnox activate zsh)"
fi

[[ -r "$ZDOTDIR/zoxide.zsh" ]] && source "$ZDOTDIR/zoxide.zsh"
