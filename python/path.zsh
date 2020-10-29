# some nice pyenv help
export PYTHONSTARTUP="$HOME/.dotfiles/python/startup.py"

if [ $commands[pyenv] ]; then
    eval "$(pyenv init -)"
fi
