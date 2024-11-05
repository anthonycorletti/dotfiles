GPG_AGENT_CONF=$HOME/.gnupg/gpg-agent.conf
if command -v pinentry-mac &> /dev/null && command -v pinentry &> /dev/null;
then
    if [ ! -f $GPG_AGENT_CONF ]; then
        echo "pinentry-program /opt/homebrew/bin/pinentry-mac" > $GPG_AGENT_CONF
    else
        if ! grep -q "pinentry-program /opt/homebrew/bin/pinentry-mac" $GPG_AGENT_CONF; then
            echo "pinentry-program /opt/homebrew/bin/pinentry-mac" > $GPG_AGENT_CONF
        fi
    fi
fi
