# some nice rbenv help
if (( $+commands[rbenv] ))
then
    eval "$(rbenv init -)"
    RUBYVERSION=2.7.1
    rbenv shell $RUBYVERSION
fi
