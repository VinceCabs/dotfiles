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

help() {
    echo "$0 <task> <args>"
    echo "Tasks:"
    compgen -A function | grep -v "^_" | cat -n
}

default() {
    help
}

"${@:-default}"