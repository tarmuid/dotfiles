if status is-interactive
    # Prefer eza for ls-style abbreviations when available.
    abbr --add --global b "brew"
    abbr --add --global bi "brew install"
    abbr --add --global brci "brew install --cask"
    abbr --add --global brcu "brew uninstall --cask"
    abbr --add --global brcz "brew uninstall --cask --zap"
    abbr --add --global bz "brew uninstall --zap"
    abbr --add --global ci "brew install --cask"
    abbr --add --global cdd "cd $DOTFILES_DIR"
    abbr --add --global dp "$DOTFILES_DIR/bin/dot"
    abbr --add --global ll "eza --long --group-directories-first --git --no-quotes"
    abbr --add --global la "eza --long --all --group-directories-first --git --no-quotes"
    abbr --add --global gg "lazygit"
    abbr --add --global md "mkdir -p"
    abbr --add --global e "nvim"
    abbr --add --global ls "eza --group-directories-first --git --no-quotes"
    abbr --add --global l "eza --long --all --group-directories-first --git --no-quotes"
end

