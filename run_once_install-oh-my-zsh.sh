#!/bin/bash
set -eu

ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no
    CHSH=no
    KEEP_ZSHRC=yes

    export RUNZSH CHSH KEEP_ZSHRC

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi