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
    cmd "/c start %USERPROFILE%\.dotfiles\bin\AutoHotkeyU64.exe %USERPROFILE%\.dotfiles\bin\ahk_scripts.ahk"
    cp $DOTFILES_PATH/bin/AutoHotkey.lnk "$APPDATA/Microsoft/Windows/Start Menu/Programs/Startup";
    echo "  AutoHotkey started and set on startup";
}

if [ $OS = "Windows_NT" ]
then
    echo "Windows detected"
    win=true
fi

echo "Git pull..."
git -C $DOTFILES_PATH pull

echo "Loading secrets..."
. $DOTFILES_PATH/.secrets

echo "Shell..."
link_dotfile .bashrc

# Git
echo "Git..."
link_dotfile .gitconfig
if $win
then
    #TODO check that it doesn't slow git
    git config --global http.sslbackend schannel
    echo "  schannel configured"
fi

# bins
echo "Bins..."
link_dotfile bin
if $win
then
    setup_autohotkey;
fi

# clean
unset -f link_dotfile
unset -f setup_autohotkey