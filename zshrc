# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="random"
ZSH_THEME="sorin"

# Example aliases
alias zshconfig="vim ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git debian history)

source $ZSH/oh-my-zsh.sh

#zstyle ':vcs_info:*' disable-patterns "$HOME/mnt(|/*)"
zstyle ':vcs_info:*' disable-patterns "*"
# Customize to your needs...
alias mntmarr='sshfs -o reconnect swhitt@marr.cse.buffalo.edu: ~/mnt/marr; cd ~/mnt/marr'
alias unmntmarr='fusermount -u ~/mnt/marr'
alias saveme='fusermount -u -z ~/mnt/marr; killall sshfs; sleep 1; killall -9 sshfs;'

alias zshdisablegit='git config --add oh-my-zsh.hide-status 1'
alias vim='gvim'
