# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab # for fuzzy find menu

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux

# Load completions
autoload -U compinit && compinit

zinit cdreplay -q # replay all cached completions


# Keybindings
# bindkey -v # vim mode
bindkey '^p' history-search-backward # Ctrl+P = only search history with current prefix
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory # zsh append any commands to history file
setopt sharehistory # share command history across all zsh sessions
setopt hist_ignore_space # prevent command from being saved to history (i.e. sensitive info) by prepending 'space'
setopt hist_save_no_dups 
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # completion ignores cases
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # completions have colors
zstyle ':completion:*' menu no # disable default menu since we're using fzf
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)" # using zoxide plugin
eval "$(starship init zsh)" # Starship


# Competitive Programming

autoload -U add-zsh-hook

cp_auto_env() {
    if [[ "$PWD" == "$HOME/Documents/competitive-programming"* ]]; then
        ulimit -s unlimited
        export PATH="$PATH:$HOME/competitive-programming/cp-setup"
    else
        export PATH=$(echo "$PATH" | sed "s|:$HOME/competitive-programming/cp-setup||")
    fi
}

add-zsh-hook chpwd cp_auto_env
cp_auto_env
source /usr/share/nvm/init-nvm.sh
