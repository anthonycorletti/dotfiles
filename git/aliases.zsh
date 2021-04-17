# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/
hub_path=$(which hub)
if (( $+commands[hub] ))
then
    alias git=$hub_path
fi

# The rest of my fun git aliases
alias gl="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(bold white)%s%C(reset) %C(white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"

alias gp='git push'

# Remove `+` and `-` from start of diff lines; just rely upon color.
alias gd='git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r'

alias gc='git commit -S -m'
alias gca='git commit -A'
alias gco='git checkout'
alias gcb='git copy-branch-name'
alias gb='git branch'
alias ga='git add -A'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias gac='git add -A && git commit -m'
alias ge='git-edit-new'
alias gpom='git push origin master'
alias gcom='git checkout master'
alias gplom='git pull origin master'
alias gpl='git pull'
alias gcl='git clone'
alias gb='git branch'
