export EDITOR='atom'
export GIT_EDITOR="atom -n -w"

# for pyenv
# https://github.com/pyenv/pyenv/issues/1219#issuecomment-448658430
export LDFLAGS="-L/usr/local/opt/zlib/lib -L/usr/local/opt/sqlite/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include -I/usr/local/opt/sqlite/include"
