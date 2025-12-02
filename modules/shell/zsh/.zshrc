# ============================================================================
# Interactive shell safety check
# ============================================================================
# If not running interactively, stop here.
# (This prevents SCP/SFTP connections from breaking due to echoed text)
[[ $- != *i* ]] && return

# ============================================================================
# Path configuration (append/prepend only)
# ============================================================================
# Note: Basic XDG paths and typeset -U path were handled in .zshenv

# Add Homebrew to path if it exists
if [[ -x "/opt/homebrew/bin/brew" ]]; then
  path=(
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
    $path
  )
fi
# ============================================================================
# Options
# ============================================================================

# History
[[ -d "${XDG_STATE_HOME}/zsh" ]] || mkdir -p "${XDG_STATE_HOME}/zsh"
export HISTFILE="$XDG_STATE_HOME/zsh/history"
export HISTSIZE=100000
export SAVEHIST=100000

setopt APPEND_HISTORY INC_APPEND_HISTORY EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS HIST_FIND_NO_DUPS HIST_IGNORE_SPACE
setopt HIST_VERIFY HIST_REDUCE_BLANKS

# Navigation
setopt AUTO_CD AUTO_PUSHD PUSHD_SILENT PUSHD_IGNORE_DUPS
setopt EXTENDED_GLOB GLOB_DOTS
setopt NO_BEEP INTERACTIVE_COMMENTS
unsetopt NOMATCH

# ============================================================================
# Keybindings (vi mode)
# ============================================================================

bindkey -v
bindkey "^?" backward-delete-char
autoload -z edit-command-line; zle -N edit-command-line
bindkey "^v" edit-command-line

# ============================================================================
# Completion
# ============================================================================

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZSH_CACHE_DIR"
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

# ============================================================================
# Plugins (ZimFW)
# ============================================================================

# Check if Zim exists; if not, install/init via Homebrew's script
local zim_brew_script="/opt/homebrew/opt/zimfw/share/zimfw.zsh"

if [[ -f "$zim_brew_script" ]] && [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE} ]]; then
  source "$zim_brew_script" init -q
fi

zstyle ':zim:ssh' ids 'id_ed25519'

[[ -f "${ZIM_HOME}/init.zsh" ]] && source "${ZIM_HOME}/init.zsh"


# ============================================================================
# Tools & aliases
# ============================================================================

# Mise
if (( $+commands[mise] )); then
  eval "$(mise activate zsh)"
fi

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