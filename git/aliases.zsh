# The rest of my fun git aliases
alias ga='git add -A'
alias gac='git add -A && git commit -S -m'
alias gb='git branch'
alias gbm="git branch | cut -c 3- | grep -E '^master$|^main$'"
alias gc='git commit -S -m'
alias gcb='git copy-branch-name'
alias gcl='git clone'
alias gco='git checkout'
alias gcom='git checkout $(gbm)'
alias gd='git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r' # Remove `+` and `-` from start of diff lines; just rely upon color.
alias ge='git-edit-new'
alias gl="git log --pretty=oneline -n 23 --graph"
alias gll="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(bold white)%s%C(reset) %C(white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias gp='git push'
alias gpl='git pull'
alias gplo='git pull origin'
alias gplom='git pull origin $(gbm)'
alias gpo='git push origin'
alias gpom='git push origin $(gbm)'
alias gplu='git pull upstream'
alias gplum='git pull upstream $(gbm)'
alias gpu='git push upstream'
alias gpum='git push upstream $(gbm)'
alias gs='git status -sb -u' # upgrade your git if -sb breaks for you. it's fun.
alias gwtf='git-wtf'
alias gf='git fetch'
alias grb='git rebase -i -S'
