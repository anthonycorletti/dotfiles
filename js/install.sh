if [[ -z $commands[spoof] ]]
then
    if [[ $commands[npm] ]]
    then
        sudo npm install spoof -g
    fi
fi

if test ! $(which n)
then
    echo "  Installing n for you via brew."
    brew install n
    # make cache folder (if missing) and take ownership
    sudo mkdir -p /usr/local/n
    sudo chown -R $(whoami) /usr/local/n
    # take ownership of node install destination folders
    sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share
fi
