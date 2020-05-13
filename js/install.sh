if [[ -z $commands[spoof] ]]
then
    if [[ $commands[npm] ]]
    then
        sudo npm install spoof -g
    fi
fi
