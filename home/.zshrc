# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Path to nixpkgs used to compile the system
export NIX_PATH="nixpkgs=$HOME/Data/Repos/nixpkgs/"

# Move custom folder so it's not located inside oh-my-zsh repository
ZSH_CUSTOM="$HOME/.oh-my-zsh-custom/"

ZSH_THEME="minimal"

# Autostart tmux if we're inside a ssh connection
# if [[ -n $SSH_CONNECTION ]]; then
#   ZSH_TMUX_AUTOSTART=true;
# fi

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  taskwarrior
  git gitignore
  pip cabal # nix-zsh-completions
  fasd # fzf
  git-extras # mosh tmux
  zsh_reload fancy-ctrl-z
  docker docker-compose
  nix
  zsh-interactive-cd
  )



# ------------------------------------------------------------------------------
# User configuration

source $ZSH/oh-my-zsh.sh

# Put noisy .zcompdump files elsewhere
compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION

# Turn off annoying [mosh] noise in terminal title
export MOSH_TITLE_NOPREFIX=1


# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Open logbook at todays date
# function lb() {
  # sh -c "$EDITOR ~/Dropbox/logbook/$(date '+%Y-%m-%d').md"
# }

# alias vgaLeft="xrandr --output VGA-a --auto --left-of LVDS-1"

# Turn off direnv output because we integrate the necessary feedback into our
# prompt
# export DIRENV_LOG_FORMAT=

# Setup direnv
# eval "$(direnv hook zsh)"

# opam configuration
# test -r /home/swhitt/.opam/opam-init/init.zsh && . /home/swhitt/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

source ~/.shellrc
