# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

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

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git svn pip lein fasd cabal git-extras gitignore mosh tmux)

# ------------------------------------------------------------------------------
# Editor (VIM obviously)
# 'vim' intelligently chooses between gui and terminal
# 'vi' is used to force terminal vim when necessary

# Detect graphical editor
if command -v mvim >/dev/null 2>&1; then
    export GUI_EDITOR=mvim
elif command -v gvim >/dev/null 2>&1; then
    export GUI_EDITOR=gvim
else
    # No gui, fall back on terminal
    export GUI_EDITOR=vim
fi

# Use terminal vim in SSH, GUI vim otherwise
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR=$GUI_EDITOR
fi

alias vim=$EDITOR

# ------------------------------------------------------------------------------
# Platform Specific

case $(uname -a) in
    *NixOS*)
        # Tab completion for manpages
        export MANPATH="/run/current-system/sw/share/man/:$HOME/.nix-profile/share/man/:$MANPATH"
        ;;

    *Darwin*)
        # Setup for Nix on OS X (added by Nix installer)
        if [ -e /Users/swhitt/.nix-profile/etc/profile.d/nix.sh ]; then
            . /Users/swhitt/.nix-profile/etc/profile.d/nix.sh; fi

        # For homebrew
        export PATH=/usr/local/bin:$PATH
        plugins+=( brew brew-cask )
        ;;
esac

# ------------------------------------------------------------------------------
# Host Specific

case $(hostname) in
    Spencers-MacBook-Pro.local)
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
