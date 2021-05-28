# this will likely fail on the first install of a fresh machine
# install gpgsuite from https://gpgtools.org

if ! type pinentry-mac > /dev/null;
then
    echo "Checking if gpg agent is running"
    if [[ gpg-agent ]]; then
        echo "Setting pinentry-program as pinentry-mac for gpg-agent. Checking if pinentry-mac is installed first."
        brew install pinentry-mac
        echo "pinentry-program /usr/local/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
    fi
fi
