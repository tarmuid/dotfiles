#!/usr/bin/env zsh

echo "dotfiles: $0"
set -eu pipefail

if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! command -v chezmoi &> /dev/null; then
    brew install chezmoi
fi

chezmoi init tarmuid/dotfiles --apply

echo "dotfiles: Run \"exec zsh\" to get your shell changes"
