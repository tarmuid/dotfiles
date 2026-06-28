export BUN_INSTALL="${BUN_INSTALL:-${XDG_DATA_HOME:-$HOME/.local/share}/bun}"
export PNPM_HOME="${PNPM_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/pnpm}"

path=("$BUN_INSTALL/bin" "$PNPM_HOME" $path)
typeset -U path
export PATH
