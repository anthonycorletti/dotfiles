alias pyclean="find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete"

function venv {
    python -m venv $1
}

function activate {
    source "$1/bin/activate"
}
