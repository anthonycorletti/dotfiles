#!/bin/sh
#
# Do some initial setup for Python
#
# We aren't going to install Python, that will be taken care of by pyenv
# but we can do some initial setup here, like setting sane defaults for pip.

pipconf="$HOME/.config/pip/pip.conf"
mkdir -p "$(dirname "$pipconf")"

if [ ! -f "$pipconf" ]; then
  cat > "$pipconf" <<EOF
[install]
require-virtualenv = true
[uninstall]
require-virtualenv = true
EOF
fi
