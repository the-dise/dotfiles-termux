# -- styles settings ---------------------------------------------------------
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu no
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b"
zstyle ':completion:*:descriptions' format '[%d]'

# -- fzf-tab styles ---------------------------------------------------------
# Use eza to preview directory contents in fzf-tab with icons and colors
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons --color=always --long --header $realpath'
zstyle ':fzf-tab:complete:fzf:*' fzf-preview 'eza --icons --color=always --long --header $realpath'
zstyle ':fzf-tab:*' switch-group '<' '>'
