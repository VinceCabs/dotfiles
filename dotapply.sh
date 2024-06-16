#!/usr/bin/env bash

# from https://sharats.me/posts/shell-script-best-practices/
set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace

DOTFILES_PATH="$HOME/.dotfiles"

###### TASKS
# inspired from (great): https://github.com/adriancooney/Taskfile

show_os_info() {  ## show OS info
    echo \
    "=============================
unamme: $(uname)
hostname: $(hostname)
OS: ${OS:-UNDEFINED}
============================="
}

detect_os() {  ## detect linux or windows
    linux=false
    win=false
    case "$(uname -s)" in
        Linux*)     echo "Linux detected" && linux=true;;
        MINGW*)     echo "Windows detected" && win=true;;
        *)          echo "unknown OS: ${uname}"
    esac
}

git_pull() {  ## pull from dotfiles repo
    echo "Git pull..."
    git -C $DOTFILES_PATH pull
}

load_secrets() {  ## load secrets from .secrets file
    echo "Loading secrets..."
    . $DOTFILES_PATH/.secrets
}

link_dotfiles() { ## generate and link all dotfiles (home -> repo)
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

setup_windows_git() {  ## specific git setup for windows
    echo "Git for windows..."
    git config --global http.sslbackend schannel
    echo "  schannel configured"
}

setup_windows_autohotkey() {  ## setup AutoHotkey for windows
    echo "AutoHotkey for windows..."
    cmd "/c start %USERPROFILE%\.dotfiles\bin\AutoHotkeyU64.exe %USERPROFILE%\.dotfiles\bin\ahk_scripts.ahk"
    cp $DOTFILES_PATH/bin/AutoHotkey.lnk "$APPDATA/Microsoft/Windows/Start Menu/Programs/Startup";
    echo "  started and set on startup";
}

setup_windows_aichat() {  ## setup Aichat for windows
    load_secrets
    echo "aichat for windows..."
    # copy config templates to config directory
    AICHAT_CONFIG_DIR=$APPDATA/aichat
    cp $DOTFILES_PATH/aichat/* $AICHAT_CONFIG_DIR
    # add secrets: region and project id in config
    sed -i "s/{REGION}/$VERTEXAI_LOCATION/g" $AICHAT_CONFIG_DIR/config.yaml
    sed -i "s/{PROJECT_ID}/$VERTEXAI_PROJECT_ID/g" $AICHAT_CONFIG_DIR/config.yaml
}

install_bins() {  ## install bins (linux and windows)
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
            docker \
            aria2 \
            bat \
            ollama \
            aichat \
        && echo "  Scoop packages installed"
    fi
    if [ "$linux" = true ] && ! command -v gh &> /dev/null
    then
        _install_gh_cli;
    fi
}

###### UTILS

_link_dotfile() {  # refresh and link a dotfile or a directory
    rm -rf ~/$1 && ln -s -f $DOTFILES_PATH/$1 ~/$1
}

_install_gh_cli() {  # install Github CLI for Linux
    type -p curl >/dev/null || sudo apt install curl -y
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y \
    && echo "  Github CLI for Linux installed"
}

_install_scoop() {  # install scoop for Windows
    command -v scoop &> /dev/null \
    || powershell -ExecutionPolicy RemoteSigned -File scoop_install.ps1
}

help() {  ## print this help (default)
    echo "$0 <task> <args>"
	grep -E '^([a-zA-Z_-]+\(\) {.*?## .*|######* .+)$$' $0 \
		| sed 's/######* \(.*\)/\n               \1/g' \
		| sed 's/\([a-zA-Z-]\+\)()/\1/' \
		| awk 'BEGIN {FS = "{.*?## "}; {printf "\033[93m%-30s\033[0m %s\033[0m\n", $1, $2}'
}

default() {
    dotapply
}

###### MAIN
dotapply() {  ## apply dotfiles (main)
    show_os_info
    git_pull
    load_secrets
    link_dotfiles
    if [ "$win" = true ]
    then
        setup_windows_git
        setup_windows_autohotkey;
        setup_windows_aichat
    fi
    install_bins
}

# run default() or run function passed as argument
detect_os
"${@:-default}"