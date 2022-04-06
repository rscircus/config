# config - moving dotfiles

Managing dotfiles in the pre-post-covid19-era.

## Motivation

Prior I used this [repo for my dotfiles](https://github.com/rscircus/dotfiles). It is a tangled mess of config files, scripts, Makefiles and package managers. Trailing the current \*nix trends towards a more and more spaghetti like state of package management[<sup>1</sup>](#fn1).

After reading about these two approaches:

- https://www.atlassian.com/git/tutorials/dotfiles
- http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html

I figured, that I'll use the prior. Eventually you'll find this: https://dotfiles.github.io/tutorials/ on your journey. It is a freaking rabbit hole... don't go there. You lose, the bank always wins.

## Usage

Clone this config like so:

```bash
mkdir -p $HOME/.src
git clone --bare https://github.com/rscircus/config $HOME/.src/config
```
And then alias it

```bash
alias config='/usr/bin/git --git-dir=$HOME/.src/config --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
```

and avoid tangling with git

```bash
echo ".src/config" >> ~/.gitignore
```

If you are prepared, you can checkout directly:

```bash
config checkout
```

Worfklow feels like

```bash
config status
config add .vimrc
config commit -m "Add vimrc"
config add .bashrc
config commit -m "Add bashrc"
config push
```

It's basically git in your `$HOME` without gitting everything in your `$HOME`.

* * *

## Tips & Tricks

If you can't checkout, backup the stuff which git/config refuses to overwrite:

```bash
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}
```

### Footnotes

[<a name="fn1">1</a>]: I'm looking at you AppImage, snap, flathub, yarn, npm, brew, rpm, deb, tar.gz, and what not.
