# Add ~/bin to path
PATH="$PATH:/Users/nko/bin"

# Add wezterm cli
PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"

# Suggest completions for hidden files/directories
setopt globdots

# Homebrew
HOMEBREW_NO_ENV_HINTS=1

# Editor
export EDITOR=nvim
alias vim="nvim"
alias vi="nvim"

# Git
alias g="git"
alias lg="lazygit"
alias gd="git diff"
alias gs="git status"

# Tmux
tmuxattach() {
if [ -z "$TMUX" ]; then
	tmux new-session -A -s main
fi
}
alias t="tmuxattach"

# Secrets
if [ -f ~/.secrets ]; then
	source ~/.secrets
fi

alias ls="ls --color=auto"
alias ll="ls -lh"
alias la="ls -A"

# Go
GOPATH=~/go
GOBIN="$GOPATH/bin"
PATH="$GOBIN:$PATH"
GOPRIVATE="go.lunarway.com,github.com/lunarway"

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

# Load Zinit
if [[ ! -f ~/.zinit/bin/zi.zsh ]]; then
  git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
fi
source ~/.zinit/bin/zi.zsh

# Work plugins
if [ -f ~/.work_zsh ]; then
	source ~/.work_zsh
fi

# My plugins
zinit ice lucid wait'0'
zinit light "zsh-users/zsh-syntax-highlighting"
zinit light "zsh-users/zsh-completions"
zinit light "zsh-users/zsh-autosuggestions"
zinit light "mafredri/zsh-async"

# Load Completions
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+168); do #Only do it once a week. No slow terminal for me please
  compinit
done
compinit -C

# Update zinit once in a while
RANDOM_NUMBER=$((RANDOM % 100 + 1))
# Check for updates and install them
if [[ $RANDOM_NUMBER -eq 1 ]]; then
  zinit self-update
  zinit update --parallel
fi


# zoxide
# eval "$(zoxide init zsh)"
# alias cd="z"

source <(fzf --zsh)

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# Starship
eval "$(starship init zsh)"

