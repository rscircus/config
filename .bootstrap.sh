# This file prepares $HOME to receive a bunch of files from the repo

## Nvim

sudo apt install neovim

mkdir -p ~/.config/nvim/
mkdir -p ~/.local/share/nvim/site
mkdir -p ~/.local/share/nvim/site/autoload
wget -O ~/.local/share/nvim/site/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

## tmux

mkdir -p ~/.tmux/plugins

### Plugins

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

## ripgrep

sudo apt install ripgrep

## find

sudo apt install fd-find

## emacs

sudo apt install emacs
