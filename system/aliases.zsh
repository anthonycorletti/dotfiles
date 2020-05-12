# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
    alias ls="gls -F --color"
    alias l="gls -lAh --color"
    alias ll="gls -l --color"
    alias la='gls -A --color'
fi

# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# internal and external ip aliases
alias internalip="ipconfig getifaddr en0"
alias externalip="curl ipecho.net/plain; echo"

# passwordss
function generate_password() {
    ((test -n "$1" && test "$1" -ge 0) && \
        openssl rand -base64 $1 | colrm $(expr $1 + 1)) 2>&-;
};

alias newpass=generate_password
