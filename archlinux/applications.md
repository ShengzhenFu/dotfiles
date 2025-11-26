# install applications

yubikey manager cli

```bash
sudo pacman -S python-pipx
pipx install yubikey-manager
export PATH="$PATH:$HOME/.local/bin"

# install necessary packages for generic USB driver for smart card readers
sudo pacman -S --needed pcsclite ccid 
sudo systemctl start  pcscd.socket
sudo systemctl enable pcscd.socket
sudo systemctl daemon-reload

ykman --version
```
```
```
