if [[ -z $commands[spoof] ]]
then
    if [[ $commands[npm] ]]
    then
        sudo npm install spoof -g
    fi
fi

if [[ -z $commands[nvm] ]]; then
    export NVM_DIR="$HOME/.nvm"
    . "/usr/local/opt/nvm/nvm.sh"
fi
