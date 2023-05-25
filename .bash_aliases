#!/usr/bin/env bash
# NOTE: My aliases that I take everywhere

# echo ALIAS FILE

# ALIAS ONLY IF THE 2nd PARAMTER IS DEFINED
function alias_if_exists() {
  # Does the alias only if the aliased program is installed
    if command -v $2 > /dev/null; then
        alias "$1"="$2"
    else
        echo Program $2 was not found
    fi
}

# PROGRAM ALIASES
alias_if_exists 'diff' 'colordiff'
# alias_if_exists 'vim' 'nvim'
alias_if_exists 'fish' 'asciiquarium'
alias_if_exists 'matrix' 'cmatrix'
alias_if_exists 'cd' 'z'

# OTHER ALIASES ----------------------------------------------
alias reload="source ~/.bashrc"
alias g++="g++ -x c++ -g -O2 -std=gnu++20 -Wall -o cpp.out"
alias scheme="podman run -it --rm inikolaev/alpine-scheme"
alias ls="ls --color=always"

# EOF

