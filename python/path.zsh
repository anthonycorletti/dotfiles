export PYTHONSTARTUP="$HOME/.dotfiles/python/startup.py"

if [ $commands[pyenv] ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
fi
