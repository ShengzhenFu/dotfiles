# ~.zshrc
export ZSH=~/.oh-my-zsh
# disable oh-my-zsh themes for pure prompt
ZSH_THEME=""
#source $ZSH/oh-my-zsh.sh
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

alias gh="cd ~/github"
alias gs="git status"
alias ll="ls -al"
alias download="cd ~/Downloads"
alias doc="cd ~/Documents"
alias key="cd ~/keys"
alias vz="nvim ~/.zshrc"
alias szh="source ~/.zshrc"
alias v="nvim"
alias tf="terraform"
alias dockerstart="open '/Applications/Docker.app/Contents/MacOS/Docker Desktop.app/'"
alias myip="curl -s https://myip.top | jq -r '{ip: .ip, country: .country, city: .city, isp: .isp}'"
alias music='launchctl load ~/Library/LaunchAgents/org.jackaudio.jackd.plist && sleep 3 && mocp'
alias stopmusic='mocp --exit && sleep 3 && launchctl unload ~/Library/LaunchAgents/org.jackaudio.jackd.plist'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source /Users/shengzhen/.config/broot/launcher/bash/br
