#!/bin/sh
set -eu

# Keep upstream matching rules; only adjust low-contrast styles.
grc_rules="$(brew --prefix grc)/share/grc"
grc_config_dir="${1:-${XDG_CONFIG_HOME:-$HOME/.config}/grc}"
mkdir -p "$grc_config_dir"
for name in dockerps kubectl ls; do
    sed -e 's/on_blue white/cyan/g' \
        -e 's/on_green bold white/bold green/g' \
        -e 's/bold white on_red/bold red/g' \
        -e 's/on_cyan bold white/bold cyan/g' \
        -e 's/bright_black/default/g' \
        "$grc_rules/conf.$name" > "$grc_config_dir/conf.$name"
done
