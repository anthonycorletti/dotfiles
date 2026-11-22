# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_ed25519.pub | pbcopy | echo '=> Public key copied to clipboard.'"

# internal and external ip aliases
alias internalip="ipconfig getifaddr en0"
alias externalip="curl ipecho.net/plain; echo"

alias l="ls -Ahl"
