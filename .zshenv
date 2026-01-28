export EDITOR="nvim"
export VISUAL="nvim"

export HISTFILE="$HOME/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/dev/flutter/bin:$PATH"

export CHROME_EXECUTABLE=/usr/bin/brave

if [[ -S "$HOME/.bitwarden-ssh-agent.sock" ]]; then
    export SSH_AUTH_SOCK="$HOME/.bitwarden-ssh-agent.sock"
fi
