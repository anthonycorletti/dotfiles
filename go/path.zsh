if test ! $GVM_ROOT; then
    source "$HOME/.gvm/scripts/gvm"

    # set go version
    GOVERSION=go1.14.1
    gvm use $GOVERSION &> /dev/null
fi
