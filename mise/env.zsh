export MISE_GLOBAL_CONFIG_FILE="$ZSH/mise/config.toml"

if command -v mise > /dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi
