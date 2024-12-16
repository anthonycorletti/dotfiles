HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt NO_BG_NICE # don't run background jobs at lower priority
setopt NO_HUP # don't kill jobs when shell exits
setopt NO_LIST_BEEP # don't beep on ambiguous completions
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps
setopt HIST_VERIFY # show command with history expansion to be executed
setopt SHARE_HISTORY # share history between sessions
setopt EXTENDED_HISTORY # add timestamps to history
setopt PROMPT_SUBST # allow command substitution in prompt
setopt CORRECT # autocorrect typos
setopt COMPLETE_IN_WORD # allow completion in the middle of a word
setopt IGNORE_EOF # don't exit on EOF

setopt APPEND_HISTORY # adds history
setopt INC_APPEND_HISTORY SHARE_HISTORY  # adds history incrementally and share it across sessions
setopt HIST_IGNORE_ALL_DUPS  # don't record dupes in history
setopt HIST_REDUCE_BLANKS # remove leading/trailing blanks from history lines

# don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
setopt complete_aliases

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
