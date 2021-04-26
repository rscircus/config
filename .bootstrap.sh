# This file prepares $HOME to receive a bunch of files from the repo

## TLDR

sudo apt install tldr

## Nvim

sudo apt install neovim

mkdir -p ~/.config/nvim/
mkdir -p ~/.local/share/nvim/site
mkdir -p ~/.local/share/nvim/site/autoload
wget -O ~/.local/share/nvim/site/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

## tmux

sudo apt install tmux
touch ~/.tmux_local

mkdir -p ~/.tmux/plugins

### Plugins

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

## ripgrep

sudo apt install ripgrep

## find

sudo apt install fd-find

## fonts

sudo apt install ibm-plex

### Jetbrains Mono - https://www.jetbrains.com/lp/mono/
cd ~/Downloads
wget https://download.jetbrains.com/fonts/JetBrainsMono-2.221.zip #update
unzip JetBrainsMono-2.221.zip
cd fonts
sudo mv JetBrainsMono-*.ttf /usr/share/fonts/
cd ..
rm -rf fonts
rm OFL.txt
rm AUTHORS.txt

### Overpass Font - https://overpassfont.org/

cd ~/Downloads
wget https://github.com/RedHatOfficial/Overpass/releases/download/3.0.2/overpass-desktop-fonts.zip
unzip overpass-desktop-fonts.zip
cd overpass
sudo mv overpass* /usr/share/fonts/
cd ../overpass-mono
sudo mv overpass* /usr/share/fonts/
cd ..
rm -rf overpass*

## sqlite3

sudo apt install sqlite3

## emacs

### requirements

sudo apt install graphviz
sudo apt install isort
sudo apt install spellcheck

sudo apt install emacs

### Configure

git clone https://github.com/rscircus/doom .doom.d
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

## TODO: openvpn

sudo apt install network-manager-openvpn-gnome

## zsh

sudo apt install zsh

### fasd

sudo apt install fasd

### oh-my-zsh

sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

### further plugins

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

### twf

go get -u github.com/wvanlint/twf/cmd/twf

### local customization

touch ~/.zshrc_local
