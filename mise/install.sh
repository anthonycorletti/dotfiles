#!/bin/sh

export PATH="$HOME/.local/bin:$PATH"

if ! command -v mise > /dev/null 2>&1
then
  echo "  Installing mise for you."
  curl https://mise.run | sh
fi
