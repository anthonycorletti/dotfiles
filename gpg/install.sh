if ! type pinentry-mac > /dev/null;
then
    brew install pinentry-mac
    echo "pinentry-program /usr/local/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
fi
