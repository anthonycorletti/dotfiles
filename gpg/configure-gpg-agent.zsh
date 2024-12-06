GPG_AGENT_CONF=$HOME/.gnupg/gpg-agent.conf
PINENTRY_MAC_PATH=/opt/homebrew/bin/pinentry-mac

if command -v pinentry-mac &> /dev/null && command -v pinentry &> /dev/null;
then
    if [ ! -f $GPG_AGENT_CONF ]; then
        echo "pinentry-program $PINENTRY_MAC_PATH" > $GPG_AGENT_CONF
    else
        if ! grep -q "pinentry-program $PINENTRY_MAC_PATH" $GPG_AGENT_CONF; then
            echo "pinentry-program $PINENTRY_MAC_PATH" > $GPG_AGENT_CONF
        fi
    fi
fi
