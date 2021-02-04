# some nice pyenv help
export PYTHONSTARTUP="$HOME/.dotfiles/python/startup.py"

# setup poetry
export PATH="$HOME/.poetry/bin:$PATH"

if [ $commands[pyenv] ]; then
    eval "$(pyenv init -)"
fi
