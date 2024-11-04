GPG_AGENT_CONF=$HOME/.gnupg/gpg-agent.conf
if command -v pinentry-mac &> /dev/null && command -v pinentry &> /dev/null;
    echo "pinentry and pinentry-mac are installed"
then
    if [ ! -f $GPG_AGENT_CONF ]; then
        echo "no gpg-agent.conf file found, creating one"
        echo "pinentry-program /opt/homebrew/bin/pinentry-mac" > $GPG_AGENT_CONF
    else
        echo "gpg-agent.conf file found"
        if ! grep -q "pinentry-program /opt/homebrew/bin/pinentry-mac" $GPG_AGENT_CONF; then
            print "pinentry-program /opt/homebrew/bin/pinentry-mac not found in gpg-agent.conf, adding it"
            echo "pinentry-program /opt/homebrew/bin/pinentry-mac" > $GPG_AGENT_CONF
        fi
    fi
fi
