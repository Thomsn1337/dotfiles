This is a collection of my dotfiles I use on my main system.

I manage my dotfiles using a **Git bare repository**. A setup guide for this method can be found [here](https://www.atlassian.com/git/tutorials/dotfiles).

# Contents

- Bash
- Btop (theming)
- Flameshot
- Neovim
- Zsh

# Installation

Clone the bare repository.

``` sh
git clone --bare git@github.com:Thomsn1337/dotfiles.git ~/.dotfiles
```

Create a temporary alias in your current shell scope to access the repository.

``` sh
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

Configure the bare repository to ignore untracked files.

``` sh
dots config --local status.showUntrackedFiles no
```

Checkout the content of the repository.

``` sh
dots checkout
```

This last step might fail because of existing config files. Delete them or back them up if needed and repeat this step.

# System-wide configs

The `misc` folder contains some system-wide configs and a package list of all required packages. Right now, they have to be installed manually. Instructions can be found in `setup.md`.

- [ ] Setup script
