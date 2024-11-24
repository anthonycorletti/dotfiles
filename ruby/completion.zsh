# assuming that rbenv was installed to `~/.rbenv`
FPATH=~/.rbenv/completions:"$FPATH"

autoload -U compinit
compinit
