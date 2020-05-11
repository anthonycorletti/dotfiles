# some nice pyenv help
export PYTHONSTARTUP="$HOME/.dotfiles/python/startup.py"
if [ $commands[pyenv] ]; then
    eval "$(pyenv init -)"
    PYTHON3VERSION=3.7.5
    PYTHON2VERSION=2.7.16
    pyenv shell $PYTHON3VERSION:$PYTHON2VERSION
fi
