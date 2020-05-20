# pyenv is great, use it

if test ! $(which pyenv)
then
    echo "  Installing pyenv for you."
    brew install pyenv
fi
