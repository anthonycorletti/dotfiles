alias pyclean="find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete"

function pip-install-save {
    pip install $1 && pip freeze | grep -i $1 | awk '{ gsub("==", ">="); print $0}' >> requirements.txt
}

function newvenv {
    python3 -m venv $1
}

function activate {
    source "$1/bin/activate"
}
