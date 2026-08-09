#!/bin/sh

set -e

mkdir -p "$HOME/.config/ghostty"
ln -sfn "$ZSH/ghostty/config" "$HOME/.config/ghostty/config"
