#!/bin/bash
# dotfiles init script
# author: therojam <github@therojam.xyz>

# define dotfiles version/place
$1=
# if $1  == 0/none then echo "you've passed now arguments to this scrip" exit

# define git repo
work =
personal =
server = 

# check if git is installed
if ! [ -x "$(command -v git)" ]; then
  echo 'Error: git is not installed.\nAborting...' >&2
  exit 1
fi

# getting dotfile from origin

echo "cloning dotfiles from gitrepo" && git clone $repo .dotfiles

# make symlinks from the git repo to ur ~
echo "creating symlinks in ~" 
ln -s ~/.dotfiles/.alias .
ln -s ~/.dotfiles/.git .
ln -s ~/.dotfiles/.gitconfig .
ln -s ~/.dotfiles/.gitignore.global .
ln -s ~/.dotfiles/ssh.config

if ! [ -x "$(command -v tmux)" ]; then
  echo 'Error: tmux is not installed.\nAborting...' >&2
  exit 1
fi
echo "getting things for tmux done"
ln -s ~/.dotfiles/.tmux.conf .
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins

echo "getting vim nice w/ Vundle + Plugins"
if ! [ -x "$(command -v vim)" ]; then
  echo 'Error: vim is not installed.\nAborting...' >&2
  exit 1
fi
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ln -s ~/.dotfiles/.vimrc .
vim +PluginInstall +qall!

echo "getting zsh nice /w oh-my-zsh"
if ! [ -x "$(command -v zsh)" ]; then
  echo 'Error: zsh is not installed.\nAborting...' >&2
  exit 1
fi
ln -s ~/.dotfiles/.zshrc .
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
source .zshrc
