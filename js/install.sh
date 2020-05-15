if [[ -z $commands[spoof] ]]
then
    if [[ $commands[npm] ]]
    then
        sudo npm install spoof -g
    fi
fi

if test ! $(which nvm)
then
    echo "  Installing nvm for you."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
fi
