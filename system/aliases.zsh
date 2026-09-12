# Use grc's built-in command rules.
[[ -s /opt/homebrew/etc/grc.zsh ]] && source /opt/homebrew/etc/grc.zsh

# Explicit config because grc's command matcher recognizes ls, not gls.
if (( $+commands[gls] )); then
    if (( $+commands[grc] )); then
        alias ls='grc --colour=auto -c conf.ls gls'
        alias l='grc --colour=auto -c conf.ls gls -Ahl --group-directories-first'
    else
        alias ls='gls --color=auto'
        alias l='gls -Ahl --group-directories-first --color=auto'
    fi
elif [[ $OSTYPE == darwin* ]]; then
    alias l='ls -Ahl'
fi

# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_ed25519.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# internal and external ip aliases
alias internalip="ipconfig getifaddr en0"
alias externalip="curl ipecho.net/plain; echo"
