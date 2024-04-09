# Add ~/bin to path
PATH="/Users/nko/bin:$PATH"

# Suggest completions for hidden files/directories
setopt globdots

# Editor
export EDITOR=nvim
alias vim="nvim"
alias vi="nvim"
alias h="hx"

# Git
alias g="git"
alias lg="lazygit"
alias gd="git diff"
alias gs="git status"

# Secrets
source ~/.secrets

# ll
alias ls="exa"
alias ll="ls -lh"

# Go
GOPATH=~/go
GOBIN="$GOPATH/bin"
PATH="$GOBIN:$PATH"

# Init zplug
source ~/.zplug/init.zsh

# Instruct zplug to use ssh for fetching plugins
ZPLUG_PROTOCOL=ssh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "zsh-users/zsh-syntax-highlighting", from:"github"
zplug "mafredri/zsh-async", from:"github", use:"async.zsh"

# Work zplug plugin
source ~/.work_zplug

# Check for updates and install them
if ! zplug check; then
    zplug install
fi

# Load all zplug plugins
zplug load

# Work env vars and functions 
source ~/.work

# zoxide
eval "$(zoxide init zsh)"
alias cd="z"

# Starship
eval "$(starship init zsh)"
