alias ls="eza --group-directories-first"
alias ll="eza -la --icons --group-directories-first"

bindkey -e

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS

setopt NO_BEEP

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#999999,bg=default,underline"
autoload -Uz compinit; compinit

zstyle ":completion:*" matcher-list "m:{a-zA-Z}={A-Za-z}"
zstyle ":completion:*" menu select
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"

zsh_autosuggestions_file="/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
zsh_syntax_highlighting_file="/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

if [[ -f $zsh_autosuggestions_file ]]; then
    source $zsh_autosuggestions_file
fi

if [[ -f $zsh_syntax_highlighting_file ]]; then
    source $zsh_syntax_highlighting_file
fi

if command -v fzf > /dev/null 2>&1; then
    source <(fzf --zsh)
fi

eval "$(starship init zsh)"
