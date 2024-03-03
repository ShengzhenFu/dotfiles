## My personal dotfiles of Tmux and NVIM

Please backup your own config, so you can revert back in case needed.

TO-DO: add video explain my workflow with Tmux and NVIM

### Oh My Zsh
```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
### zplug
```bash
brew install zplug

#Configure ~.zshrc

export ZSH=~/.oh-my-zsh
# disable oh-my-zsh themes for pure prompt
ZSH_THEME=""
source $ZSH/oh-my-zsh.sh
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug load
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
```
```bash
zplug "plugins/web-search",   from:oh-my-zsh
zplug "plugins/jsontools",   from:oh-my-zsh
zplug "plugins/z",   from:oh-my-zsh
zplug "plugins/copyfile",   from:oh-my-zsh
zplug "plugins/copypath",   from:oh-my-zsh
```
