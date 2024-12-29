
https://arch.icekylin.online/guide/rookie/basic-install.html#_9-%E5%AE%89%E8%A3%85%E7%B3%BB%E7%BB%9F
https://wiki.archlinux.org/title/Installation_guide

```bash
setfont ter-124b
# verify the boot mode, check the UEFI bitness, If the command returns 64, then system is booted in UEFI mode and has a 64-bit x64 UEFI.
cat /sys/firmware/efi/fw_platform_size
# check network connection, the wlan0 is down atm
ip link
# check WiFi driver, T480 result is Intel Corporation Wireless 8265 / 8275 (rev 78)
lspci -k | grep Network
# 查看无线连接 是否被禁用(blocked: yes)
rfkill list 
#比如无线网卡看到叫 wlan0
ip link set wlan0 up
# if wlan0 up has error, run below to unblock
rfkill unblock wifi

# configure WiFi
iwctl
device list
station wlan0 scan
station wlan0 get-networks
station wlan0 connect wifi-name
exit
# run ip link, wlan0 should be UP now
ping www.bilibili.com -c 5
ping archlinux.org -c 5
# clock
timedatectl set-ntp true
timedatectl status
# if you're in China, update the mirror source
vim /etc/pacman.d/mirrorlist
# add below lines at the beginning
Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch # 中国科学技术大学开源镜像站
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch # 清华大学开源软件镜像站
Server = https://repo.huaweicloud.com/archlinux/$repo/os/$arch # 华为开源镜像站
Server = http://mirror.lzu.edu.cn/archlinux/$repo/os/$arch # 兰州大学开源镜像站

# disk partition
cfdisk /dev/nvme0n1
# choose the free space, new, Partition size: 8G -> change type to Linux swap
# new partition with rest of the free space, type to Linux filesystem
# write & then quit
# now you should be able to see Linux swap and filesystem in the partition
fdisk -l
# format the new partitions
mkfs.fat -F 32 /dev/nvme0n1p7
mkswap /dev/nvme0n1p6
# btrfs
mkfs.btrfs -f -L archlinux /dev/nvme0n1p7
mount -t btrfs -o compress=zstd /dev/nvme0n1p7 /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume list -p /mnt
umount /mnt

mount -t btrfs -o subvol=/@,compress=zstd /dev/nvme0n1p7 /mnt
mkdir /mnt/home
mount -t btrfs -o subvol=/@home,compress=zstd /dev/nvme0n1p7 /mnt/home
mkdir -p /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot
swapon /dev/nvme0n1p6
df -h
free -h

# install system packages
pacstrap -K /mnt base base-devel linux linux-firmware btrfs-progs
# if encounter GPG error, please run below
pacman -S archlinux-keyring
# install other packages
pacstrap -K /mnt networkmanager vim sudo zsh zsh-completions

# generate fstab
genfstab -U /mnt > /mnt/etc/fstab
cat /mnt/etc/fstab

arch-chroot /mnt

echo "archlinux" > /etc/hostname
vim /etc/hosts
127.0.0.1   localhost
::1         localhost
127.0.1.1   archlinux.localdomain archlinux


ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc

vim /etc/locale.gen
# uncomment en_US.UTF-8 and zh_CN.UTF-8
locale-gen
echo 'LANG=en_US.UTF-8'  > /etc/locale.conf

passwd root

pacman -S intel-ucode

# Grub
pacman -S grub efibootmgr os-prober
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=ARCH
vim /etc/default/grub
GRUB_DEFAULT=0
GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR="Arch"
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=5 nowatchdog"
GRUB_CMDLINE_LINUX=""
GRUB_DISABLE_OS_PROBER=false


sudo grub-mkconfig -o /boot/grub/grub.cfg

blkid /dev/nvme0n1p3
# take note UUID=E8CD-0171
vim /boot/grub/grub.cfg
# add lines at ### BEGIN /etc/grub.d/30_os_prober
menuentry 'Microsoft Windows 10' {
    insmod part_gpt
    insmomd fat
    insmod chain
    search --fs-uuid --no-floppy --set=root E8CD-0171
    chainloader ($(root))/EFI/Microsoft/Boot/bootmgfw.efi
}

exit # 退回安装环境
umount -R /mnt # 卸载新分区
reboot # 重启


systemctl enable --now NetworkManager # 设置开机自启并立即启动 NetworkManager 服务
nmtui
pacman -S fastfetch

useradd -m -G wheel,storage,power -s /bin/bash shengzhen

# https://github.com/3rfaan/arch-everforest
# aur
cd $HOME && mkdir aur
cd aur
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si

sudo pacman -S spice-vdagent xf86-video-qxl
sudo pacman -S virtualbox-guest-utils
sudo pacman -S alsa-utils alsa-plugins
sudo pacman -S pipewire pipewire-alsa pipewire-pulse wireplumber
sudo pacman -S openssh
sudo pacman -S iw wpa_supplicant
sudo systemctl enable sshd
sudo systemctl enable dhcpcd

sudo pacman -S bluez bluez-utils blueman
sudo systemctl enable bluetooth

$ sudo nvim /etc/pacman.conf
Uncomment Color and add below it ILoveCandy.
Uncomment ParallelDownloads = 5

$ sudo systemctl enable fstrim.timer
$ sudo pacman -S ntp
$ sudo systemctl enable ntpd
$ timedatectl set-ntp true

$ sudo pacman -S hyprland hyprpaper swayidle
$ yay -S wlogout swaylock-effects-git

sudo pacman -S mesa intel-media-driver libva-intel-driver vulkan-intel
sudo pacman -S noto-fonts ttf-opensans ttf-firacode-nerd
sudo pacman -S noto-fonts-emoji
$ sudo pacman -S noto-fonts-cjk
$ sudo pacman -S zsh
$ chsh -s $(which zsh)
$ sudo pacman -S alacritty kitty
$ sudo pacman -S wofi
$ sudo pacman -S waybar
$ sudo pacman -S ranger nemo
$ sudo pacman -S python-pillow
$ sudo pacman -S imv
sudo pacman -S firefox
$ yay -S hyprshot
$ yay -S obs-studio-git
$ sudo pacman -S vlc
$ sudo pacman -S zathura zathura-pdf-mupdf
$ sudo pacman -S gammastep

$ gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
$ gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

$ sudo pacman -S --needed nodejs npm rust go ruby rubygems php composer lua luarocks python python-pip dotnet-runtime dotnet-sdk julia java-runtime-common java-environment-common jdk-openjdk

$ yay -S pfetch hyprshot
$ sudo pacman -S fd ripgrep bat eza tree-sitter tree-sitter-cli inetutils

$ cd $HOME; mkdir paru
$ git clone https://aur.archlinux.org/paru.git
$ cd paru
$ makepkd -si

$ vim /etc/hosts
185.199.108.133  raw.githubusercontent.com

$ yay -S ml4w-hyprland-git
$ ml4w-hyprland-setup
```

