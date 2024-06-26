setopt HIST_SAVE_NO_DUPS

autoload -U compinit; compinit
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

alias ls='eza -a --group-directories-first'
alias ll='eza -laH --group-directories-first'   # show long listing of all except ".."

alias lsc='live-server --browser=chromium'    # Start live-server with Chromium
alias lsf='live-server --browser=firefox'     # Start live-server with Firefox

alias lgit='lazygit'

alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ldots='lazygit --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

function plugin() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
        source "$ZDOTDIR/plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
        source "$ZDOTDIR/plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
    fi
}

plugin "zsh-users/zsh-autosuggestions"
plugin "zsh-users/zsh-completions"
plugin "zsh-users/zsh-syntax-highlighting"

eval "$(starship init zsh)"
