#!/usr/bin/env bash

echo \
"=============================
unamme: $(uname)
hostname: $(hostname)
OS: $OS
============================="

DOTFILES_PATH="$HOME/.dotfiles"

link_dotfile() {
    rm -f ~/$1 && ln -s -f $DOTFILES_PATH/$1 ~/$1
}

echo "Git pull..."
git -C $DOTFILES_PATH pull

echo "Loading secrets..."
source $DOTFILES_PATH/.secrets

echo "Shell..."
test .bashrc_local && source .bashrc_local
link_dotfile .bashrc

# Git
echo "Git..."
link_dotfile .gitconfig
git config --global user.email "$GH_EMAIL"  # secret email
# git config --global credentials.helper wincred  # Windows Only

# Utils
# prepend_path() {
#   if [ -d "$1" ]; then
#     export PATH="$1:$PATH"
#   fi
# }
