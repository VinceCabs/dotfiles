#!/usr/bin/env bash

# from https://sharats.me/posts/shell-script-best-practices/
set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace

DOTFILES_PATH="$HOME/.dotfiles"

# UTILS

_link_dotfile() {
    rm -rf ~/$1 && ln -s -f $DOTFILES_PATH/$1 ~/$1
}

_setup_autohotkey() {
    cmd "/c start %USERPROFILE%\.dotfiles\bin\AutoHotkeyU64.exe %USERPROFILE%\.dotfiles\bin\ahk_scripts.ahk"
    cp $DOTFILES_PATH/bin/AutoHotkey.lnk "$APPDATA/Microsoft/Windows/Start Menu/Programs/Startup";
    echo "  AutoHotkey started and set on startup";
}

_install_gh_cli() {
    type -p curl >/dev/null || sudo apt install curl -y
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y
}

# MAIN TASKS
# inspired from (great): https://github.com/adriancooney/Taskfile

show_os_info() {
    echo \
    "=============================
unamme: $(uname)
hostname: $(hostname)
OS: $OS
============================="
}

detect_os() {
    linux=false
    win=false
    case "$(uname -s)" in
        Linux*)     echo "Linux detected" && linux=true;;
        MINGW*)     echo "Windows detected" && win=true;;
        *)          echo "unknown OS: ${uname}"
    esac
}

git_pull() {
    echo "Git pull..."
    git -C $DOTFILES_PATH pull
}

load_secrets() {
    echo "Loading secrets..."
    . $DOTFILES_PATH/.secrets
}

link_dotfiles() {
    echo "Link dotfiles..."
    _link_dotfile .bashrc
    _link_dotfile .gitconfig
    _link_dotfile bin
}

setup_windows_git() {
    if [ $win ]
    then
        echo "Git for windows..."
        git config --global http.sslbackend schannel
        echo "  schannel configured"
    fi
}

install_bins() {
    #TODO: update bins (https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c)
    echo "Bins..."
    if [ $win ]
    then
        _setup_autohotkey;
    fi
    if [ $linux ] && ! command -v gh &> /dev/null
    then
        _install_gh_cli;
        echo "  Github CLI for Linux installed"
    fi
}

help() {
    echo "$0 <task> <args>"
    echo "Tasks:"
    compgen -A function | cat -n
}

default() {
    dotapply
}

# MAIN
dotapply() {
    show_os_info
    detect_os
    git_pull
    load_secrets
    link_dotfiles
    setup_windows_git
    install_bins
}

"${@:-default}"