#!/usr/bin/env bash

echo \
"=============================
unamme: $(uname)
hostname: $(hostname)
OS: $OS
============================="

export DOTFILES_PATH="$HOME/.dotfiles"

link_dotfile() {
    rm -f ~/$1 && ln -s -f $DOTFILES_PATH/$1 ~/$1
}

echo "git pull..."
git -C $DOTFILES_PATH pull

echo "loading secrets..."
source $DOTFILES_PATH/.secrets

echo "shell..."
link_dotfile .bashrc

# Git
echo "git..."
link_dotfile .gitconfig
git config --global user.email "$GH_EMAIL"  # secret email
# git config --global credentials.helper wincred  # Windows Only

# Utils
# prepend_path() {
#   if [ -d "$1" ]; then
#     export PATH="$1:$PATH"
#   fi
# }
