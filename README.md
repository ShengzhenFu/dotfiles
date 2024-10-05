## Everything on Terminal


### My personal dotfiles of Tmux and NVIM

Please backup your own config, so you can revert back in case needed.

TO-DO: add video explain the power of Terminal with Tmux, NVIM and more...

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

# for intel chip
# export ZPLUG_HOME=/usr/local/opt/zplug

# for apple silicon
export ZPLUG_HOME=/opt/homebrew/opt/zplug

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
zplug "plugins/emoji",  from:"oh-my-zsh"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2, on:"zsh-users/zsh-autosuggestions"
zplug "zdharma/fast-syntax-highlighting", as:"plugin", defer:2
zplug "plugins/emoji-clock",  from:"oh-my-zsh"
zplug "plugins/git",  from:"oh-my-zsh"
```
## Window manager
```bash
brew install --cask amethyst
```


## Nvim short cuts i find useful

### copy all content to clipboard
ggVGy

### pop up a terminal in Nvim and hide it
Space + fT

Esc + Ctrl \ + Ctrl n + : q

### install Golang pkg
```bash
curl -o go1.23.pkg https://dl.google.com/go/go1.23.0.darwin-amd64.pkg
```

### install productivity terminal tools
```bash
brew install neovim tmux wget fzf ripgrep node yarn pnpm tfenv jq k9s yazi shellcheck
```
### trouble-shooting
markdown plugin of neovim no longer in maintain, so if the MarkdownPreview is not working, please run below command to manual install it
```bash
nvim
:call mkdp#util#install()
```

### Useful commands
#### caffeinate (keep macbook awake)
```bash
# Prevent Mac display from sleeping
caffeinate -d
# Prevent the system from idle sleeping 
caffeinate -i 
# Prevent the disk from going idle
caffeinate -m
# Keep Mac awake while plugged into AC power 
caffeinate -s 
# Here, 1800 is the time in seconds your Mac will stay awake.You can set any time of your choice.
caffeinate -t 1800 &
```
#### Git
https://docs.github.com/en/enterprise-server@3.12/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
git config --global user.email "your_email@example.com"
git config --global user.name "your_name"
```

### future work
migrate neovim markdown preview plugin to new project https://github.com/jannis-baum/Vivify


