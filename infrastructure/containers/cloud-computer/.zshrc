# Ignore checking for multiple antigens running simultaneously
ANTIGEN_MUTEX=false

# Load antigen plugin manager
source antigen.zsh

# Use oh-my-zsh framework
antigen use oh-my-zsh

# Bundles from oh-my-zsh
antigen bundle command-not-found
antigen bundle docker
antigen bundle docker-compose
antigen bundle fzf
antigen bundle git
antigen bundle git-auto-fetch
antigen bundle gnu-utils
antigen bundle kubectl
antigen bundle ubuntu

# Bundles from third parties
antigen bundle buonomo/yarn-completion
antigen bundle lukechilds/zsh-nvm
antigen bundle paulirish/git-open
antigen bundle popstas/zsh-command-time
antigen bundle zdharma/zsh-diff-so-fancy
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-history-substring-search

# Load the theme
antigen theme avit

# Apply antigen plugins
antigen apply

# Disable zsh errors when no globs are matched
unsetopt nomatch

# Do not remove spaces when piping commands
ZLE_REMOVE_SUFFIX_CHARS=

# Set zsh history file location
export HISTFILE=$HOME/.cache/zsh/histfile
mkdir -p $(dirname $HISTFILE)

# Highlight the cloud computer icon in the shell prompt if we're on a remote machine
export CLOUD_COMPUTER_ZSH_ENVIRONMENT_ICON_CHAR=⛀
export CLOUD_COMPUTER_ZSH_ENVIRONMENT_ICON_COLOUR=white
if [ "$TERRAFORM_TARGET" = "cloud-computer" ]; then
  export CLOUD_COMPUTER_ZSH_ENVIRONMENT_ICON_CHAR=⛃
  export CLOUD_COMPUTER_ZSH_ENVIRONMENT_ICON_COLOUR=magenta
fi

# Show the cloud computer sync status in the prompt
export CLOUD_COMPUTER_ZSH_SYNC_ICON_CHAR=⬆
export CLOUD_COMPUTER_ZSH_SYNC_ICON_COLOUR=yellow
if [ "$TERRAFORM_TARGET" = "cloud-computer" ]; then
  export CLOUD_COMPUTER_ZSH_SYNC_ICON_CHAR=↓
fi

# Report local or remote sync status
if [ "$TERRAFORM_TARGET" = "cloud-computer" ]; then
  export CLOUD_COMPUTER_ZSH_SYNC_CHECK="docker ps | grep -q cloud-computer-sync"
else
  export CLOUD_COMPUTER_ZSH_SYNC_CHECK="pkill -0 --full sync:watch"
fi

# Set the sync status
if eval $CLOUD_COMPUTER_ZSH_SYNC_CHECK; then
  export CLOUD_COMPUTER_ZSH_SYNC_STATUS="%{$fg[$CLOUD_COMPUTER_ZSH_SYNC_ICON_COLOUR]%}$CLOUD_COMPUTER_ZSH_SYNC_ICON_CHAR "
fi

# Set the shell prompt
export PROMPT='
${_current_dir}%{$fg[$CLOUD_COMPUTER_ZSH_ENVIRONMENT_ICON_COLOUR]%}$CLOUD_COMPUTER_ZSH_ENVIRONMENT_ICON_CHAR $CLOUD_COMPUTER_ZSH_SYNC_STATUS$(git_prompt_info)
%{$fg[$CARETCOLOR]%}▶%{$resetcolor%} '

# Alias git commands
alias a="git a"
alias aa="git added"
alias ap="git ap"
alias cam="git cam"
alias camp="git camp"
alias cln="git cln"
alias co="git co"
alias cob="git cob"
alias cop="git cp"
alias d="git d"
alias p="git p"
alias pp="git pp"
alias pu="git pu"
alias s="git s"

# Alias common commands to better alternatives
alias ascii="figlet -f slant -m 2"
alias c=cat
alias cat=bat
alias f=fzf
alias g=grep
alias gg=lazygit
alias imgur=imgur-uploader
alias pastebin="curl -F 'f:1=<-' ix.io"
alias ptree="ps xf -o pid,ppid,pgrp,euser,args"
alias scripts="cat package.json | jq .scripts"
alias t="tmux -S $CLOUD_COMPUTER_TMUX/.tmux.sock"
alias tn="TMUX= t new-session -s on-demand-$(date +%M%S) -t"
alias ts="t display-message -p '#S'"
alias tree="tree -a -I 'node_modules|.git' -L 4"
alias u=".."
alias uu="..."
alias uuu="...."
alias v=vcsh
alias vcshp="VCSH_REPO_D=$HOME/.config/vcsh/repo-private.d vcsh"
alias vd="vcsh foreach diff"
alias vp=vcshp
alias vps="vcshp status"
alias vpd="vcshp foreach diff"
alias vs="vcsh status"
alias x='xargs -n 1 -I %'

# Load jump shell
eval "$(jump shell zsh)"
