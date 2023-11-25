#!/usr/bin/env bash
DOTFILES_PATH="$HOME/.dotfiles"
RCLONE_REMOTE_NAME=gcp_perso
TIMEFORMAT="Task completed in %3lR"

load_secrets() {
    echo "Loading secrets..."
    . $DOTFILES_PATH/.secrets
}

rclone_setup() {
    # TODO document .secrets
    load_secrets
    rclone config create \
        $RCLONE_REMOTE_NAME \
        "google cloud storage" \
        project_number=$RCLONE_GOOGLE_STORAGE_PROJECT_NUMBER \
        location=eu \
        storage_class=ARCHIVE \
        bucket_policy_only=true
}

rclone_backup() {
    # accepts flags as arguments (ex: `--dry-run -vv`)
    # need a `rclone_filter_list.txt` file located in source, remove if you want to backup all
    load_secrets
    rclone sync --progress $@ \
        --filter-from $RCLONE_BACKUP_SOURCE_PATH/rclone_filter_list.txt \
        $RCLONE_BACKUP_SOURCE_PATH \
        $RCLONE_REMOTE_NAME:$RCLONE_GOOGLE_STORAGE_BUCKET
}

# UTILS

_link_dotfile() {
    rm -rf ~/$1 && ln -s -f $DOTFILES_PATH/$1 ~/$1
}

help() {
    echo "$0 <task> <args>"
    echo "Tasks:"
    compgen -A function | grep -v "^_" | cat -n
}

default() {
    help
}

_link_dotfile tasks.sh
"${@:-default}"