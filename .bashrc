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