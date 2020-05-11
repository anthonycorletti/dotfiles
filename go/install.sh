#!/bin/bash

if ! type gvm > /dev/null;
then
    echo "Installing gvm for you."
    bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
fi
