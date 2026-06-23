HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

mkdir -p "${HISTFILE:h}"

setopt autocd
setopt extendedglob
setopt histignorealldups
setopt histignorespace
setopt incappendhistory
setopt interactivecomments
setopt sharehistory

unsetopt beep
