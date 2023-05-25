#!/usr/bin/env bash

# echo "BASHRC Loaded"

# ------------------------------ history -----------------------------

export HISTCONTROL=ignoreboth
export HISTSIZE=5000
export HISTFILESIZE=10000

set -o vi
shopt -s histappend

# ------------------------ bash shell options ------------------------

# shopt is for BASHOPTS, set is for SHELLOPTS

shopt -s checkwinsize  # enables $COLUMNS and $ROWS
shopt -s expand_aliases
shopt -s globstar
shopt -s dotglob
shopt -s extglob

# ------------------------------ modular -----------------------------
# ENVIRONMENT SETUP --------------------------------
if [ -f ~/.env ]; then
    source ~/.env
fi

# ALIASES ----------------------------------------------
if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

# MY SHELL SCRIPTS -----------------------------------------
for file in ~/.tools/*.sh; do
    . $file
done

# BASH PROMPT ---------------------------------------------------
if [ -f ~/.bash_prompt ]; then
    source ~/.bash_prompt
fi

# EOF

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

