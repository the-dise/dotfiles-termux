# -- exit shell --------------------------------------------------------------
alias :q='exit'

# -- file operations with safety prompts -------------------------------------
alias ..='cd ..'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -ri'
alias md='mkdir -p'
alias rd='rmdir'

# -- list directory contents -------------------------------------------------
# Use eza (a modern ls replacement) with options suited for Termux
alias l='eza --git --header --long --color=always --icons'
alias ls='eza'
alias ll='eza --git --header --color=always --icons'
alias la='eza --all --git --header --long --color=always --icons'

# -- colorize ----------------------------------------------------------------
# Use bat and other tools with color support if available
alias bat="bat --color=always"
alias grep="grep --color=always"
alias diff="diff --color=auto"
alias ncdu="ncdu --color=dark --extended --enable-delete"

# -- open files in Neovim with fzf -------------------------------------------
fzf-nvim() {
  local file
  file=$(fzf) || return 1
  [ -n "$file" ] && nvim "$file"
}
alias nvifz='fzf-nvim'

# -- miscellaneous -----------------------------------------------------------
alias c='clear' # Clear terminal

# Alias to open file manager
# Instead, use termux-open or another Termux-friendly file manager
alias open='termux-open'

# -- system info -------------------------------------------------------------
alias ff='fastfetch' # Display system information
alias ffa="fastfetch -c all.jsonc"
alias k='uname -rs'             # Display kernel name and version
alias age='stat / | grep Birth' # Display system installation date

# -- clipboard operations ----------------------------------------------------
# Clipboard operations using termux-clipboard
alias pbcopy='termux-clipboard-set'  # Copy to clipboard in Termux
alias pbpaste='termux-clipboard-get' # Paste from clipboard in Termux
