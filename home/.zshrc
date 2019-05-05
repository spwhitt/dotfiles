# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Move custom folder so it's not located inside oh-my-zsh repository
ZSH_CUSTOM=$HOME/.oh-my-zsh-custom/

ZSH_THEME="spaceship"

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
  git gitignore svn
  pip cabal
  fasd git-extras mosh
  zsh_reload fancy-ctrl-z
  docker docker-compose yarn
  tmux colored-man-pages
  )

# ------------------------------------------------------------------------------
# Editor (VIM obviously)

export TERMINAL="xfce4-terminal"
export EDITOR="emacsclient -s /tmp/emacs1000/server -c"
export VISUAL="$EDITOR"
alias vim=nvim

# Create new emacs frame and raise it to top
alias e=$EDITOR
# alias e='emacsclient -e "(select-frame-set-input-focus (selected-frame))" -c -a ""'

# ------------------------------------------------------------------------------
# Platform Specific

case $(uname -a) in
    *NixOS*)
        # Tab completion for manpages
        # export MANPATH="/run/current-system/sw/share/man/:$HOME/.nix-profile/share/man/:$MANPATH"
        alias open="xdg-open"
        ;;

    *Darwin*)
        # Setup for Nix on OS X (added by Nix installer)
        # if [ -e /Users/swhitt/.nix-profile/etc/profile.d/nix.sh ]; then
        #   . /Users/swhitt/.nix-profile/etc/profile.d/nix.sh; fi

        # For homebrew
        export PATH=/usr/local/bin:/Users/swhitt/.local/bin:$PATH
        ;;
esac

# ------------------------------------------------------------------------------
# Host Specific

case $(hostname) in
    Spencers-MacBook-Pro.local)
        # The next line updates PATH for the Google Cloud SDK.
        if [ -f /Users/swhitt/google-cloud-sdk/path.zsh.inc ]; then
          source '/Users/swhitt/google-cloud-sdk/path.zsh.inc'
        fi

        # The next line enables shell command completion for gcloud.
        if [ -f /Users/swhitt/google-cloud-sdk/completion.zsh.inc ]; then
          source '/Users/swhitt/google-cloud-sdk/completion.zsh.inc'
        fi

        export PYTHONPATH=$HOME/TVS/caffe/python:$PYTHONPATH

        # Point to my personal copy of nixpkgs
        export NIX_PATH=$NIX_PATH:$HOME/nixpkgs/:nixpkgs=$HOME/nixpkgs/
        ;;
esac

# ------------------------------------------------------------------------------
# User configuration

source $ZSH/oh-my-zsh.sh

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

function mkcd () {
  mkdir $1; cd $1;
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Open logbook at todays date
function lb() {
  $EDITOR ~/logbook/$(date '+%Y-%m-%d').md
}

alias vgaLeft "xrandr --output VGA-a --auto --left-of LVDS-1"

alias dtrx "dtrx --one=I"

eval "$(direnv hook zsh)"
