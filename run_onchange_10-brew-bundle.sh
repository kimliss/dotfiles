#!/bin/bash
set -e

if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew is not installed"
    exit 1
fi

BREWFILE="$HOME/.Brewfile"

if [ ! -f "$BREWFILE" ]; then
    echo "Brewfile not found: $BREWFILE"
    exit 1
fi

# Brewfile: {{ include "dot_Brewfile" | sha256sum }}

brew bundle --file="$BREWFILE"