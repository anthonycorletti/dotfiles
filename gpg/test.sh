echo "Checking if gpg agent is running"
if [[ gpg-agent ]]; then
    echo "Installing pinentry mac for you."
    brew install pinentry-mac
    echo "pinentry-program /usr/local/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
fi
