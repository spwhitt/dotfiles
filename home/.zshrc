# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Path to DOOM Emacs Config
# export DOOMDIR=$HOME/.emacsconfig/doom

# Move custom folder so it's not located inside oh-my-zsh repository
ZSH_CUSTOM=$HOME/.oh-my-zsh-custom/

ZSH_THEME="spaceship"

SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  package       # Package version
  node          # Node.js section
  ruby          # Ruby section
  elixir        # Elixir section
  xcode         # Xcode section
  swift         # Swift section
  golang        # Go section
  php           # PHP section
  rust          # Rust section
  haskell       # Haskell Stack section
  julia         # Julia section
  docker        # Docker section
  aws           # Amazon Web Services section
  direnv
  venv          # virtualenv section
  conda         # conda virtualenv section
  pyenv         # Pyenv section
  dotnet        # .NET section
  ember         # Ember.js section
  kubecontext   # Kubectl context section
  terraform     # Terraform workspace section
  exec_time     # Execution time
  line_sep      # Line break
  battery       # Battery level and status
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

SPACESHIP_DIRENV_SHOW="${SPACESHIP_DIRENV_SHOW=true}"
SPACESHIP_DIRENV_PREFIX="${SPACESHIP_DIRENV_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_DIRENV_SUFFIX="${SPACESHIP_DIRENV_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_DIRENV_SYMBOL="${SPACESHIP_DIRENV_SYMBOL="!"}"
# The (A) expansion flag creates an array, the '=' activates word splitting
# SPACESHIP_DIRENV_GENERIC_NAMES="${(A)=SPACESHIP_DIRENV_GENERIC_NAMES=virtualenv venv .venv}"
SPACESHIP_DIRENV_COLOR="${SPACESHIP_DIRENV_COLOR="blue"}"

# Promp section for direnv
spaceship_direnv() {
  [[ $SPACESHIP_DIRENV_SHOW == false ]] && return

  # Check if direnv is loaded
  [ -n "$DIRENV_DIFF" ] || return

  local 'venv'

  # if [[ "${SPACESHIP_DIRENV_GENERIC_NAMES[(i)$VIRTUAL_ENV:t]}" -le \
        # "${#SPACESHIP_DIRENV_GENERIC_NAMES}" ]]
  # then
    # venv="$VIRTUAL_ENV:h:t"
  # else
    # venv="$VIRTUAL_ENV:t"
  # fi

  spaceship::section \
    "$SPACESHIP_DIRENV_COLOR" \
    "$SPACESHIP_DIRENV_PREFIX" \
    "${SPACESHIP_DIRENV_SYMBOL}${venv}" \
    "$SPACESHIP_DIRENV_SUFFIX"
}

# Autostart tmux if we're inside a ssh connection
if [[ -n $SSH_CONNECTION ]]; then
  ZSH_TMUX_AUTOSTART=true;
fi

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
  git gitignore
  pip cabal # nix-zsh-completions
  fasd # fzf
  git-extras # mosh tmux
  zsh_reload fancy-ctrl-z
  docker docker-compose
  )

# ------------------------------------------------------------------------------
# Editor (VIM obviously)

export TERMINAL='alacritty'
# export EDITOR="emacsclient -s /tmp/emacs1000/server -c"
export EDITOR='nvim'
export VISUAL="$EDITOR"


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

source ~/.shellenv
