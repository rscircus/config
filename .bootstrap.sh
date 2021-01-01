# This file prepares $HOME to receive a bunch of files from the repo

## Nvim

mkdir -p ~/.config/nvim/
mkdir -p ~/.local/share/nvim/site
mkdir -p ~/.local/share/nvim/site/autoload
wget -O ~/.local/share/nvim/site/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
