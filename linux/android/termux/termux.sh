#!/data/data/com.termux/files/usr/bin/bash

termux-wake-lock

# Misc

rm 	~/.termux/font.ttf
mkdir 	~/.termux
wget -O ~/.termux/font.ttf "URI"

### Create usr/local

mkdir -p /data/data/com.termux/files/usr/local/bin/
echo -n 'export PATH=$PATH:/data/data/com.termux/files/usr/local/bin/'		>> ~/.bashrc
echo -n 'set -gx PATH $PATH #!/data/data/com.termux/files/usr/local/bin/'	>> ~/.config/fish/config.fish

# Apt

pkg update
pkg upgrade
pkg install root-repo unstable-repo x11-repo #repo
pkg install proot bsdtar curl wget fish vim neovim git tmux #tools

## Pacapt

wget -O /data/data/com.termux/files/usr/local/bin/pacapt https://github.com/icy/pacapt/raw/ng/pacapt
chmod 755 /data/data/com.termux/files/usr/local/bin/pacapt
ln -sv /data/data/com.termux/files/usr/local/bin/pacapt /data/data/com.termux/files/usr/local/bin/pacman || true
fish -c 'abbr pacman pacapt'

# Termux-Arch

curl -OL https://raw.githubusercontent.com/TermuxArch/TermuxArch/master/setupTermuxArch.bash|bash

# Fish

chsh -s fish
curl https://raw.githubusercontent.com/koumaza/dot/master/termux/fish/termux-config.fish >> ~/.config/fish/config.fish

# Finish

termux-wake-unlock
