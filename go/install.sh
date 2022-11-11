#!/bin/bash
#
# use g, it is nice
#

if test ! $(which g)
then
    echo "  Installing g for you."
    curl -sSL https://git.io/g-install | sh -s -- -y
fi
