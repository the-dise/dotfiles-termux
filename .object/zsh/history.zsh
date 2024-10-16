HISTSIZE=5000
HISTFILE=~/.zhistory
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt append_history
setopt extended_history
setopt share_history
setopt inc_append_history

setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
setopt hist_ignore_space
setopt hist_verify
