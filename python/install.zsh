#!/bin/sh
# pyenv is great, use it

if test ! $commands[pyenv]
then
  echo "  Installing pyenv for you."
  brew install pyenv
fi
