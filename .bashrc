DOTFILES_PATH="$HOME/.dotfiles"
. $DOTFILES_PATH/.secrets

# Utils
prepend_path() {
  if [ -d "$1" ]; then
    export PATH="$1:$PATH"
  fi
}

# aliases
alias ll='ls -alF'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias g="git"
alias gsutil="gsutil.cmd"
alias python3="python"
alias activate="source .venv/Scripts/activate ; source .venv/bin/activate"  # both exist
alias cl="clear"
alias gauth="gcloud auth login && gcloud auth application-default login"

# sync dotfiles
alias dotapply="sh $HOME/.dotfiles/dotapply.sh"

# add .bashrc_local if exists
[[ -f $HOME/.bashrc_local ]] && . $HOME/.bashrc_local

# add Google Cloushell bashrc
if [ -f "/google/devshell/bashrc.google" ]; then
  source "/google/devshell/bashrc.google"
fi

# Git
export GIT_AUTHOR_EMAIL=$GH_EMAIL
export GIT_COMMITTER_EMAIL=$GH_EMAIL

# bin
prepend_path $HOME/bin