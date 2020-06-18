#!/bin/bash
#
# use gvm, it is nice
#

if test ! $(which gvm)
then
    echo "  Installing gvm for you."
    zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
fi