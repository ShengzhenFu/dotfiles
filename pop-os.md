# Pop OS

## fcitx5 Chinese input method
https://zhuanlan.zhihu.com/p/1891416207569166711

```bash

sudo apt-get install fcitx5 fcitx5-configtool fcitx5-chinese-addons fcitx5-frontend-gtk3 fcitx5-frontend-qt5

cat <<'EOF' | sudo tee -a /etc/environment
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
SDL_IM_MODULE=fcitx
GLFW_IM_MODULE=ibus
EOF

sudo apt install zenity
im-config
sudo dpkg-divert --package im-config --rename /usr/bin/ibus-daemon
sudo rm /etc/profile.d/pop-im-ibus.sh

reboot
```


## check battery

```bash
upower -e
upower -i /org/freedesktop/UPower/devices/battery_BAT0
upower -i /org/freedesktop/UPower/devices/battery_BAT1
```
