#!/usr/bin/env bash

echo \
"=============================
unamme: $(uname)
hostname: $(hostname)
OS: $OS
============================="

# Dotfiles path
export DOTFILES_PATH="$HOME/.dotfiles"

echo "git pull..."
git -C $DOTFILES_PATH pull

echo "loading secrets..."
source $DOTFILES_PATH/.secrets

echo "shell..."
# source $DOTFILES_PATH/.bash_aliases
export DOTFILE=".bashrc"
rm -f ~/$DOTFILE && ln -s -f $DOTFILES_PATH/$DOTFILE ~/$DOTFILE

# Git
echo "git..."
export DOTFILE=".gitconfig"
rm -f ~/$DOTFILE && ln -s -f $DOTFILES_PATH/$DOTFILE ~/$DOTFILE
git config --global user.email "$GH_EMAIL"  # secret email
# git config --global credentials.helper wincred  # Windows Only

# Utils
# prepend_path() {
#   if [ -d "$1" ]; then
#     export PATH="$1:$PATH"
#   fi
# }
