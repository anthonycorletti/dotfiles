#
# for installing versions with pyenv
# https://github.com/pyenv/pyenv/issues/1219#issuecomment-448658430
#
# https://github.com/pyenv/pyenv/issues/1737#issuecomment-833177844
# https://github.com/pyenv/pyenv/issues/1643

export LDFLAGS="-L/usr/local/opt/zlib/lib -L/usr/local/opt/sqlite/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include -I/usr/local/opt/sqlite/include"
export VIRTUAL_ENV_DISABLE_PROMPT=1
export PYTHONSTARTUP="$HOME/.dotfiles/python/startup.py"
