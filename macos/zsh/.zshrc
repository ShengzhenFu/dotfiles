export ZSH="$HOME/.oh-my-zsh"
# source $ZSH/oh-my-zsh.sh
# disable oh-my-zsh themes for pure prompt
ZSH_THEME=""
source $ZSH/oh-my-zsh.sh

# for intel chip
# export ZPLUG_HOME=/usr/local/opt/zplug

# for apple silicon
export ZPLUG_HOME=/opt/homebrew/opt/zplug

source $ZPLUG_HOME/init.zsh

# Async for zsh, used by pure
zplug "mafredri/zsh-async", from:github, defer:0

# oh-my-zsh
zplug "lib/completion", from:oh-my-zsh
zplug "lib/directories", from:oh-my-zsh
zplug "lib/functions", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh
zplug "lib/theme-and-appearance", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
# zplug "plugins/z", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/emoji", from:oh-my-zsh
zplug "plugins/jsontools", from:oh-my-zsh
zplug "plugins/web-search", from:oh-my-zsh
zplug "plugins/copy-file", from:oh-my-zsh
zplug "plugins/copypath", from:oh-my-zsh

# zsh-users
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3
# zplug "zdharma/fast-syntax-highlighting", defer:2

# theme
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
# zplug "oddhorse/bubblegum-zsh", use:bubblegum.zsh-theme, as:theme


# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

alias vz="nvim ~/.zshrc"
alias v="nvim"
alias szh="source ~/.zshrc"

export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="$PATH:$HOME/.local/bin"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
