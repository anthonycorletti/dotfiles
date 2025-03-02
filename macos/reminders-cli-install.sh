#!/bin/sh -ex

# Install reminders-cli
# if reminders is in path, pass
# otherwise, check if reminders-cli is cloned to ~/reminders-cli
# if not, clone it
# if it is, cd into it and run make build-release, cp .build/apple/Products/Release/reminders /usr/local/bin/reminders

if ! command -v reminders &> /dev/null; then
  cur_dir=$PWD
  git clone https://github.com/keith/reminders-cli.git $HOME/reminders-cli
  cd $HOME/reminders-cli
  make build-release
  cp .build/apple/Products/Release/reminders /usr/local/bin/reminders
  cd $cur_dir
fi
