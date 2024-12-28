## zsh

```bash
# install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# install zsh plugin
# sudo pacman -S --needed zsh-autosuggestions
# sudo pacman -S --needed zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete

sed -i 's/plugins=(git)/plugins=(git sudo archlinux zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)/g' ~/.zshrc
```

## tmux

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# add below lines to the bottom of ~/.tmux.conf
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'christoomey/vim-tmux-navigator'
# set -g @plugin 'catppuccin/tmux'
set -g @plugin 'dreamsofcode-io/catppuccin-tmux'
set -g @plugin 'tmux-plugins/tmux-yank'
run '~/.tmux/plugins/tpm/tpm'
```


## audio

```bash
sudo pacman -S --needed pulseaudio pulseaudio-alsa
systemctl --user start pulseaudio
```

## Chinese input

```bash
sudo pacman -S --needed fcitx5-chinese-addons
sudo pacman -S --needed fcitx5-im fcitx5-pinyin-zhwiki
sudo pacman -S --needed fcitx5-configtool
# run fcitx5-configtool to add Chinese input pinyin
# add 1 line in hyprland.conf
exec-once=fcitx5 --replace -d
# add below lines to /etc/environment
GTK_IM_MODULES=fcitx5
QT_IM_MODULES=fcitx5
SDL_IM_MODULES=fcitx5
XMODIFIERS=@im=fcitx5
#################################

# auto mount U disk
sudo pacman -S --needed udiskie
```

## unmute audio

```bash
sudo pacman -S alsa-utils
amixer sset Master unmuter
```

## tools

```bash
paru -S auto-cpufreq
```

## backup

```bash
rsync -avz --progress --exclude='.cache' --exclude='node_modules' --exclude='.venv' /home/shengzhen/ /run/media/shengzhen/1675-9DDB/t480/archlinux/backup/

rsync -avz --progress /home/shengzhen/.cache/wal/ /run/media/shengzhen/1675-9DDB/t480/archlinux/backup/.cache/wal/

paru -S pika-backup
```

## clash

```bash
cd ~/.config/mihomo
./clash-linux
```

## obs

https://gist.github.com/brunoanc/2dea6ddf6974ba4e5d26c3139ffb7580#install-pipewire-and-friends

```bash
sudo pacman -S pipewire wireplumber 
yay -S xdg-desktop-portal-hyprland-git
# remove other packages, ONLY keep xdg-desktop-portal-hyprland and xdg-desktop-portal-gtk
pacman -Q | grep xdg-desktop-portal-
# add dependencies
sudo pacman -S grim slurp
# add below line to the end of ~/.config/hypr/hyprland.conf
exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
```
