typeset -U path

path=("$HOME/.local/bin" $path)

export PATH
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

if [[ -z "${XDG_CONFIG_DIRS:-}" ]]; then
  xdg_dirs=(/etc/xdg)
  if [[ "$OSTYPE" == darwin* ]]; then
    [[ -d /usr/local/etc/xdg ]] && xdg_dirs=(/usr/local/etc/xdg $xdg_dirs)
    [[ -d /opt/homebrew/etc/xdg ]] && xdg_dirs=(/opt/homebrew/etc/xdg $xdg_dirs)
  fi
  export XDG_CONFIG_DIRS="${(j.:.)xdg_dirs}"
  unset xdg_dirs
fi

if [[ -z "${XDG_DATA_DIRS:-}" ]]; then
  xdg_dirs=(/usr/local/share /usr/share)
  if [[ "$OSTYPE" == darwin* ]]; then
    [[ -d /opt/homebrew/share ]] && xdg_dirs=(/opt/homebrew/share $xdg_dirs)
  fi
  export XDG_DATA_DIRS="${(j.:.)xdg_dirs}"
  unset xdg_dirs
fi


export EDITOR="${EDITOR:-vi}"
export PAGER="${PAGER:-less}"
