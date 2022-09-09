#!/usr/bin/env bash

echo \
"=============================
unamme: $(uname)
hostname: $(hostname)
OS: $OS
============================="

DOTFILES_PATH="$HOME/.dotfiles"

link_dotfile() {
    rm -rf ~/$1 && ln -s -f $DOTFILES_PATH/$1 ~/$1
}

setup_autohotkey() {
    cp $DOTFILES_PATH/bin/AutoHotkey.lnk "$APPDATA/Microsoft/Windows/Start Menu/Programs/Startup";

    echo "...AutoHotkey set on startup (restart required)";
}

echo "Git pull..."
git -C $DOTFILES_PATH pull

echo "Loading secrets..."
. $DOTFILES_PATH/.secrets

echo "Shell..."
link_dotfile .bashrc

# Git
echo "Git..."
link_dotfile .gitconfig

# bins
echo "Bins..."
link_dotfile bin
if [ $OS = "Windows_NT" ]
then
    echo "...Windows detected"
   setup_autohotkey;
fi

# clean
unset -f link_dotfile
unset -f setup_autohotkey