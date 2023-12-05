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

_install_gh_cli() {
    type -p curl >/dev/null || sudo apt install curl -y
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y \
    && echo "  Github CLI for Linux installed"
}

_install_scoop() {
    command -v scoop &> /dev/nullecho \
    || powershell -ExecutionPolicy RemoteSigned -File scoop_install.ps1
}

# MAIN TASKS
# inspired from (great): https://github.com/adriancooney/Taskfile

show_os_info() {
    echo \
    "=============================
unamme: $(uname)
hostname: $(hostname)
OS: ${OS:-UNDEFINED}
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
    # create .bashrc if not exists and 
    [[ -f ./.bashrc ]] || touch ~/.bashrc
    # add snippet to source .bashrc_local if not  present
    if ! grep ".bashrc_local" ~/.bashrc 1> /dev/null
    then
        cat .bashrc.snippet >> ~/.bashrc
    fi
    # links
    _link_dotfile .bashrc_local; source ~/.bashrc
    _link_dotfile .gitconfig
    _link_dotfile bin
}

setup_windows_git() {
    echo "Git for windows..."
    git config --global http.sslbackend schannel
    echo "  schannel configured"
}

setup_windows_autohotkey() {
    echo "AutoHotkey for windows..."
    cmd "/c start %USERPROFILE%\.dotfiles\bin\AutoHotkeyU64.exe %USERPROFILE%\.dotfiles\bin\ahk_scripts.ahk"
    cp $DOTFILES_PATH/bin/AutoHotkey.lnk "$APPDATA/Microsoft/Windows/Start Menu/Programs/Startup";
    echo "  started and set on startup";
}

install_bins() {
    #TODO: update bins (https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c)
    echo "Bins..." 
    if [ "$win" = true ]
    then
        # install packages if scoop present
        _install_scoop
        scoop install \
            nodejs \
            gh \
            rclone \
            yt-dlp \
            ffmpeg \
        && echo "  Scoop packages installed"
    fi
    if [ "$linux" = true ] && ! command -v gh &> /dev/null
    then
        _install_gh_cli;
    fi
}

help() {
    echo "$0 <task> <args>"
    echo "Tasks:"
    compgen -A function | grep -v "^_" | cat -n
}

default() {
    dotapply
}

# MAIN
dotapply() {
    show_os_info
    git_pull
    load_secrets
    link_dotfiles
    if [ "$win" = true ]
    then
        setup_windows_git
        setup_windows_autohotkey;
    fi
    install_bins
}

# run default() or run function passed as argument
detect_os
"${@:-default}"