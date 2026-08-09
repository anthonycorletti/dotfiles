#!/bin/sh

set -e

if ! command -v pinentry-mac > /dev/null 2>&1; then
  exit 0
fi

gpg_agent_conf="$HOME/.gnupg/gpg-agent.conf"
pinentry_mac_path="$(command -v pinentry-mac)"
pinentry_setting="pinentry-program $pinentry_mac_path"

mkdir -p "$(dirname "$gpg_agent_conf")"
touch "$gpg_agent_conf"

if grep -q '^pinentry-program ' "$gpg_agent_conf"; then
  sed -i.bak "s|^pinentry-program .*|$pinentry_setting|" "$gpg_agent_conf"
  rm -f "$gpg_agent_conf.bak"
elif ! grep -Fqx "$pinentry_setting" "$gpg_agent_conf"; then
  printf '%s\n' "$pinentry_setting" >> "$gpg_agent_conf"
fi
