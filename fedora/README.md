# Post-installation of Fedora 43 workstation

download the iso from fedoraproject.org/workstation/download/

```bash
# install zsh on Fedora
sudo dnf install zsh
sudo dnf install zsh-autosuggestions zsh-syntax-highlighting

sudo lchsh $USER
# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete

cat <<'EOF' | tee -a $HOME/.zshrc
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)
EOF

# install apps
sudo dnf install keepassxc google-chrome fd fzf curl
# install localsend
flatpak install flathub org.localsend.localsend_app
flatpak run org.localsend.localsend_app

# neovim
# https://www.youtube.com/watch?v=Wj1y_eAhlvc&t=682s

git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# download font from https://www.nerdfonts.com/font-downloads 
mkdir ~/.fonts
copy *.otf ~/.fonts

sudo dnf install fd fzf
sudo dnf install @development-tools

# github ssh key
ssh-keygen -t ed25519 -C changeme@mail.com
git config --global user.email changeme@mail.com
git config --global user.name yourname
# verify the connection
ssh -T git@github.com

# install go-lang
sudo dnf install golang
mkdir -p $HOME/go
# configure go proxy to CN
cat <<'EOF' | tee -a $HOME/.zshrc
# export GOPATH
export GOPATH="$HOME/go"
export GO111MODULE=on
export GOPROXY=https://goproxy.cn
EOF

source $HOME/.zshrc
go env GOPATH

# zellij
# download from https://zellij.dev/
mkdir $HOME/bin
tar -zxvf zellij.tar.gz
mv zellij $HOME/bin
cat <<'EOF' | tee -a $HOME/.zshrc
export PATH="$PATH:$HOME/bin"
EOF
source $HOME/.zshrc


# docker engine
sudo dnf remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

sudo dnf config-manager addrepo --from-repofile https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl enable --now docker

sudo usermod -aG docker $USER
newgrp docker
docker version

# mihomo
mkdir -p $HOME/.config/mihomo
cd $HOME/.config/mihomo
wget https://github.com/MetaCubeX/mihomo/releases/download/v1.19.18/mihomo-linux-amd64-compatible-v1.19.18.gz
gzip -d mihomo-linux-amd64-compatible-v1.19.18.gz
chmod +x mihomo-linux-amd64-compatible-v1.19.18

#docker pull ghcr.io/metacubex/metacubexd
docker load -i $HOME/Downloads/metacubex.tar
docker run -d -p 30080:80 --name metacubexd ghcr.io/metacubex/metacubexd
docker run -d --restart always -p 30080:80 --name metacubexd ghcr.io/metacubex/metacubexd

cat <<'EOF' | tee -a $/HOME/.zshrc
alias ipsecui='docker run -d -p 30080:80 --name metacubexd ghcr.io/metacubex/metacubexd'
alias ipsec='cd $HOME/.config/mihomo; nohup ./mihomo-linux-amd64-compatible-v1.19.18 > output.log 2>&1 &' 
alias setproxy='export http_proxy=http://127.0.0.1:7890; export https_proxy=http://127.0.0.1:7890; export all_proxy=http://127.0.0.1:7890'

alias v='nvim'
alias vz='nvim ~/dotfiles/.config/zshrc'
alias szh='source ~/.zshrc'
EOF


# devpod cli
curl -L -o devpod "https://github.com/loft-sh/devpod/releases/latest/download/devpod-linux-amd64" && sudo install -c -m 0755 devpod /usr/local/bin && rm -f devpod

# openssh
sudo systemctl status sshd
sudo systemctl start sshd
sudo systemctl enable --now sshd
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --reload
sudo firewall-cmd --list-all


# gnome extensions
# URL: https://extensions.gnome.org/extension/1460/vitals/
# URL: https://extensions.gnome.org/extension/517/caffeine/

# cockpit
sudo dnf install cockpit
vim /usr/lib/systemd/system/cockpit.socket
# update the listener port to 39090
sudo systemctl start cockpit.socket
sudo systemctl enable --now cockpit.socket
sudo firewall-cmd --add-service=cockpit
sudo firewall-cmd --add-service=cockpit --permanent

# fcitx5
sudo dnf install fcitx5 fcitx5-configtool fcitx5-autostart
sudo dnf install fcitx5-chinese-addons fcitx5-table-extra
im-chooser

# VLC
sudo dnf install vlc

# allow icmp
sudo firewall-cmd --permanent --remove-icmp-block-inversion
sudo firewall-cmd --reload
sudo firewall-cmd --list-all

# samba
sudo dnf install samba samba-client
sudo mkdir -p /data/shares
sudo useradd -r -M -s /sbin/nologin cloudtea
sudo chown -R cloudtea:cloudtea /data/shares
sudo smbpasswd -a cloudtea
# sudo pdbedit -a -u cloudtea
id cloudtea
getent passwd cloudtea
chcon -R -t samba_share_t /data/shares
sudo semanage fcontext --add --type "samba_share_t" "/data/shares(/.*)?"
sudo restorecon -R /data/shares
sudo chmod 777 /data/shares

## disable SELinux
sudo setenforce 0
cat <<'EOF' | sudo tee /etc/samba/smb.conf > /dev/null
[global]
        server string = Samba Server
        security = user
        # workgroup = WORKGROUP
        # netbios name = system
        # client max protocol = SMB3
        # hosts allow = 127. 192.168.0.215

        # log files split per-machine:
        log file = /var/log/samba/%m.log
        # maximum size of 50KB per log file, then rotate:
        max log size = 50

[shares]
        comment = Shared Directories
        path = /data/shares
        browsable = yes
        public = yes
        writable = yes
        create mask = 0660
        directory mask = 0770
        valid users = cloudtea
EOF

# validate smb.conf syntax
testparm /etc/samba/smb.conf
sudo firewall-cmd --add-service=samba --permanent
sudo firewall-cmd --reload
sudo systemctl start smb --now
sudo systemctl enable smb
sudo systemctl start nmb --now
sudo systemctl enable nmb

sudo smbstatus
```
