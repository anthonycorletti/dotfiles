if ! command -v pinentry-mac &> /dev/null;
then
    brew install pinentry-mac
    echo "pinentry-program /opt/homebrew/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf 
fi
