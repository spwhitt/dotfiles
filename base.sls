# Initial SLS file
# Performs installation on OSX using saltstack
# 
# TODO:
  # Add support for debian/ubuntu
  # Split + organize file
  # Incorporate misc. features from the old install.sh

{% set user="swhitt" %}
{% set home="/Users/{{ user }}" %}

Basic Utilities:
  pkg:
    - installed
    - names:
      - macvim
      - htop-osx
      - mobile-shell
      - python
      - zsh
      - git
      - hg

  # Install pip with easy_install
  cmd:
    - run
    - name: easy_install pip
    - unless: ls /usr/local/bin/pip

{{ user }}:
  user:
    - present
    - fullname: Spencer Whitt
    - shell: /bin/zsh
    - home: {{ home }}

oh-my-zsh:
  git:
    - latest
    - name: git://github.com/robbyrussell/oh-my-zsh.git
    - target: {{ home }}/.oh-my-zsh
    - user: {{ user }}

zshrc:
  file:
    - managed
    - name: {{ home }}/.zshrc
    - source: salt://zshrc
    - user: {{ user }}

vimrc:
  # Vimrc
  file:
    - managed
    - name: {{ home }}/.vimrc
    - source: salt://vimrc
    - user: {{ user }}

  # Install vundle plugin manager
  git:
    - latest
    - name: https://github.com/gmarik/vundle.git 
    - target: {{ home }}/.vim/bundle/vundle
    - user: {{ user }}

  # Install all vim plugins with vundle
  cmd:
    - run
    - name: vim +BundleInstall +qall
    - user: {{ user }}
    - unless: ls ~/.vim/bundle
    - watch:
      - file: vimrc

Git Config:
  file:
    - managed
    - name: {{ home }}/.gitconfig
    - source: salt://gitconfig
    - user: {{ user }}

#iTerm2:
#  archive:
#    - extracted
#    - name: /tmp/iterm2
#    - source: http://iterm2.com/downloads/stable/iTerm2_v1_0_0.zip
#    - archive_format: zip
