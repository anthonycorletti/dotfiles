source <(helm completion zsh | sed -E 's/\["(.+)"\]/\[\1\]/g')
