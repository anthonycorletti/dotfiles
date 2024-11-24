# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
    alias l="gls -Ahl --group-directories-first --color"
fi

# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_ed25519.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# internal and external ip aliases
alias internalip="ipconfig getifaddr en0"
alias externalip="curl ipecho.net/plain; echo"

# automatic aliases for grc
[[ -s "/opt/homebrew/etc/grc.zsh" ]] && source /opt/homebrew/etc/grc.zsh
