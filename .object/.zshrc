# -- set environment variables -------------------------------------------------
export AUTOSTART_TMUX=false
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export DOTFILES="$HOME/.dotfiles-termux"
export PATH="$PATH:$HOME/.local/bin:$HOME/.termux/usr/bin"

# -- initialize completion -----------------------------------------------------
autoload -Uz compinit && compinit

# Load local environment variables if available
[[ -f "$DOTFILES/zsh/.env" ]] && source "$DOTFILES/zsh/.env"

# -- initialize starship prompt ------------------------------------------------
eval "$(starship init zsh)"

# -- setup zinit ---------------------------------------------------------------
export ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
   mkdir -p "$(dirname "$ZINIT_HOME")"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "$ZINIT_HOME/zinit.zsh"

# -- load zinit plugins --------------------------------------------------------
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light Freed-Wu/fzf-tab-source

# -- vi mode configuration -----------------------------------------------------
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
export ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

# -- fzf search plugin ---------------------------------------------------------
zinit ice lucid wait'0'
zinit light joshskidmore/zsh-fzf-history-search

# -- load OMZP (Oh My Zsh Plugins) snippets ------------------------------------
zinit snippet OMZP::git
zinit snippet OMZP::command-not-found
zinit snippet OMZP::colorize

# -- load custom configurations (history, styles, aliases, etc.) ---------------
source "$DOTFILES/zsh/history.zsh"
source "$DOTFILES/zsh/zstyles.zsh"
source "$DOTFILES/zsh/aliases.zsh"

# Make sure fzf is installed and source the plugin if available
if command -v fzf &>/dev/null; then
   source "$DOTFILES/zsh/plugins/fzf/fzf.plugin.zsh"
fi

# Make sure tmux is installed and source the plugin if available
if command -v tmux &>/dev/null; then
   source "$DOTFILES/zsh/plugins/tmux/tmux.plugin.zsh"
fi

# -- sysinfo on startup --------------------------------------------------------
if command -v fastfetch &>/dev/null; then
   fastfetch
fi
