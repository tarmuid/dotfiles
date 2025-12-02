# ------------------------------------------------------------------------------
# 0. XDG base directory specification
# ------------------------------------------------------------------------------

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_BIN_HOME="$HOME/.local/bin"

# ------------------------------------------------------------------------------
# 1. ZDOTDIR
# ------------------------------------------------------------------------------

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# ------------------------------------------------------------------------------
# 2. Path configuration
# ------------------------------------------------------------------------------

# Ensure path array is unique (removes duplicates automatically)
typeset -U path PATH

# Prepend user binaries to the path
path=(
    "$XDG_BIN_HOME"
    "$path[@]"
)

export PATH

# ------------------------------------------------------------------------------
# 3. Homebrew
# ------------------------------------------------------------------------------
eval "$(/opt/homebrew/bin/brew shellenv)"

# ------------------------------------------------------------------------------
# 4. Default programs
# ------------------------------------------------------------------------------

export EDITOR="vim"
export VISUAL="$EDITOR"
export PAGER="less"

# ------------------------------------------------------------------------------
# 5. Application XDG enforcement
# ------------------------------------------------------------------------------

# Keep the home directory clean by forcing apps to use XDG dirs
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export LESSHISTFILE="$XDG_STATE_HOME/less/history"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export DOTFILES_DIR="$XDG_DATA_HOME/dotfiles"

# ------------------------------------------------------------------------------
# 6. ZimFW / plugin manager settings
# ------------------------------------------------------------------------------
# It is best to set these here so they are ready before .zshrc loads
export ZIM_HOME="$ZDOTDIR/.zim"
export ZIM_CONFIG_FILE="$ZDOTDIR/.zimrc"

# Zsh caching
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
export ZSH_COMPDUMP="$ZSH_CACHE_DIR/zcompdump"
