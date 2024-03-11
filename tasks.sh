#!/usr/bin/env bash

# from https://sharats.me/posts/shell-script-best-practices/
set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace

DOTFILES_PATH="$HOME/.dotfiles"
RCLONE_REMOTE_NAME=gcp_perso
TIMEFORMAT="Task completed in %3lR"

###### TASKS

load_secrets() {  ## load secrets from .secrets file
    echo "Loading secrets..."
    . $DOTFILES_PATH/.secrets
}

rclone_setup() {  ## setup rclone (requires GCP project number in .secrets file)
    load_secrets
    rclone config create \
        $RCLONE_REMOTE_NAME \
        "google cloud storage" \
        project_number=$RCLONE_GOOGLE_STORAGE_PROJECT_NUMBER \
        location=eu \
        storage_class=ARCHIVE \
        bucket_policy_only=true
}

rclone_backup() {  ## launch backup (requires filter file, accepts arguments ex: `--dry-run -vv`)
    # need a `rclone_filter_list.txt` file located in source, remove if you want to backup all
    load_secrets
    rclone sync --progress $@ \
        --filter-from $RCLONE_BACKUP_SOURCE_PATH/rclone_filter_list.txt \
        $RCLONE_BACKUP_SOURCE_PATH \
        $RCLONE_REMOTE_NAME:$RCLONE_GOOGLE_STORAGE_BUCKET
}

get_template() {  ## copy tasks.sh template to current directory
    cp $DOTFILES_PATH/tasks.sh.template ./tasks.sh
}

###### UTILS

_link_dotfile() {
    rm -rf ~/$1 && ln -s -f $DOTFILES_PATH/$1 ~/$1
}

help() {  ## print this help (default)
	echo "$0 <task> <args>"
	grep -E '^([a-zA-Z_-]+\(\) {.*?## .*|######* .+)$$' $0 \
		| sed 's/######* \(.*\)/\n               \1/g' \
		| sed 's/\([a-zA-Z-]\+\)()/\1/' \
		| awk 'BEGIN {FS = "{.*?## "}; {printf "\033[93m%-30s\033[0m %s\033[0m\n", $1, $2}'
}

default() {
    help
}

_link_dotfile tasks.sh
"${@:-default}"