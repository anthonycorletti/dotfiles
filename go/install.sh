#!/bin/bash

if ! type go > /dev/null;
then
    echo "Installing go for you with brew."
    brew install go
fi
