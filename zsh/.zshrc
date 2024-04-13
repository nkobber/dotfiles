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
if [ -f ~/.secrets ]; then
	source ~/.secrets
fi

# ll
alias ls="exa"
alias ll="ls -lh"

# Go
GOPATH=~/go
GOBIN="$GOPATH/bin"
PATH="$GOBIN:$PATH"

# zsh settings
## History command configuration
export HISTSIZE=50000
export SAVEHIST=10000
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history
# Changing/making/removing directory
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# Init zplug
source ~/.zplug/init.zsh

# Instruct zplug to use ssh for fetching plugins
ZPLUG_PROTOCOL=ssh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "lib/completion", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", from:"github"

# Work zplug plugin
if [ -f ~/.work_zplug ]; then
	source ~/.work_zplug
fi

# Load all zplug plugins
zplug load

# Work env vars and functions 
if [ -f ~/.work ]; then
	source ~/.work
fi

# zoxide
eval "$(zoxide init zsh)"
alias cd="z"

# Starship
eval "$(starship init zsh)"
