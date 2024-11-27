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
