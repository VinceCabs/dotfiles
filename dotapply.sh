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

install_gh_cli() {
    type -p curl >/dev/null || sudo apt install curl -y
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y
}

case "$(uname -s)" in
    Linux*)     echo "Linux detected" && linux=true;;
    MINGW*)     echo "Windows detected" && win=true;;
    *)          echo="unknown OS: ${uname}"
esac

echo "Git pull..."
git -C $DOTFILES_PATH pull

echo "Loading secrets..."
. $DOTFILES_PATH/.secrets

echo "Shell..."
link_dotfile .bashrc

# Git
echo "Git..."
link_dotfile .gitconfig
if [ $win ]
then
    #TODO check that it doesn't slow git
    git config --global http.sslbackend schannel
    echo "  schannel configured"
fi

# bins
#TODO: update bins (https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c)
echo "Bins..."
link_dotfile bin
if [ $win ]
then
    setup_autohotkey;
fi
if [ $linux ] && ! command -v gh &> /dev/null
then
    install_gh_cli;
    echo "  Github CLI for Linux installed"
fi

# clean
unset -f link_dotfile
unset -f setup_autohotkey