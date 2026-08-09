#!/bin/sh

set -e

rm -rf "$HOME/.config/nvim"
mkdir -p "$HOME/.config"
cp -R "$ZSH/nvim/.config/nvim" "$HOME/.config/nvim"
