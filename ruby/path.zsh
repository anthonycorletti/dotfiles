# some nice rbenv help
if (( $+commands[rbenv] ))
then
    eval "$(rbenv init -)"
    RUBYVERSION=2.6.5
    rbenv shell $RUBYVERSION
fi
