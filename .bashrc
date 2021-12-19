DOTFILES_PATH="$HOME/.dotfiles"
. $DOTFILES_PATH/.secrets

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

# Git
export GIT_AUTHOR_EMAIL=$GH_EMAIL
export GIT_COMMITTER_EMAIL=$GH_EMAIL