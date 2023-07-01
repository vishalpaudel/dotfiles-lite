#!/usr/bin/env bash

# ------------------------------ history -----------------------------
export HISTCONTROL=ignoreboth
export HISTSIZE=5000
export HISTFILESIZE=10000
export HISTFILE=~/.cache/.bash_history

set -o vi
shopt -s histappend

# ------------------------ bash shell options ------------------------
# shopt is for BASHOPTS, set is for SHELLOPTS

shopt -s checkwinsize  # enables $COLUMNS and $ROWS
shopt -s expand_aliases
shopt -s globstar
shopt -s dotglob
shopt -s extglob
shopt -s direxpand                          # expands directory when tabbing

# ------------------------------ env -----------------------------
# NOTE: Environment Setup, Shell Agnostic. Should work both with bash and zsh(X)

# Language Specific Paths -----------------------------------
export PYTHONPATH="/opt/homebrew/Cellar/python@3.11/3.11.*/bin"
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home/"

# Helper functions for path ---------------------------------
function prepend_path() {
    for prog in $@; do
        # Does the alias only if the aliased program is installed
        if [ -d "$prog" ]; then
            export PATH="$prog:$PATH"
        else
            echo Program "$prog" not found
        fi
    done
}
function append_path() {
    for prog in $@; do
        # Does the alias only if the aliased program is installed
        if [ -d "$prog" ]; then
            export PATH="$PATH:$prog"
        else
            echo Program "$prog" not found
        fi
    done
}

# Can do in a single line or with '\'
# prepend_path "$HOME/local/bin"                                  # Local bins
# prepend_path "$HOME/bin"                                        # Custom scripts
# prepend_path "/opt/homebrew/opt/llvm/bin"
# prepend_path "/opt/homebrew/opt/openjdk/bin"
prepend_path "/opt/homebrew/bin"                                # Homebrew

append_path "$PYTHONPATH"                                       # Python
# append_path "$JAVA_HOME"                                        # Java

# OTHERS ----------------------------------------------------
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export SHELL="bash"

export XDG_CONFIG_HOME="$HOME/.config"
export TERM="xterm-256color"
export CLICOLOR=YES
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# Configure Editor ------------------------------------------
export EDITOR=vi
export VISUAL=vi
export EDITOR_PREFIX=vi

# ----------------------- environment variables ----------------------
export DOTFILES="$HOME/dotfiles-lite"
export SCRIPTS="$HOME/.scripts"
export CP_HOME="$HOME/Documents/competitive-programming"

# MISC SOFTWARE --------------------------------------------
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

eval "$(zoxide init bash)"

# OS specific ----------------------------------------------
case "$(uname -s)" in
    Darwin)
        ;;
    Linux)
        ;;
    CYGWIN*|MINGW32*|MSYS*)
        ;;
    *)
      # Default case
        ;;
esac

# EOF

# ALIASES ----------------------------------------------
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# --------------------------- smart prompt ---------------------------
#                 (keeping in bashrc for portability)

PROMPT_LONG=40
PROMPT_MAX=95
PROMPT_AT=@

__ps1() {
	local P='$' dir="$(echo ${PWD##*/} | cut -d' ' -f1-2
)" B countme short long double\
    r='\[\e[31m\]' g='\[\e[30m\]' h='\[\e[34m\]' \
    u='\[\e[33m\]' p='\[\e[34m\]' w='\[\e[35m\]' \
    b='\[\e[36m\]' x='\[\e[0m\]'

  [[ $EUID == 0 ]] && P='#' && u=$r && p=$u # root
  [[ $PWD = / ]] && dir=/
  [[ $PWD = "$HOME" ]] && dir='~'

  B=$(git branch --show-current 2>/dev/null)
  [[ $dir = "$B" ]] && B=.
  countme="$USER$PROMPT_AT$(hostname):$dir($B)\$ "

  [[ $B == master || $B == main ]] && b="$r"
  [[ -n "$B" ]] && B="$g($b$B$g)"

  short="$u\u$g$PROMPT_AT$h\h$g:$w$dir$B$p$P$x "
  long="${g}╔ $u\u${g}$PROMPT_AT$h\h${g}:$w$dir$B\n${g}╚ $p$P$x "
  double="${g}╔ $u\u${g}$PROMPT_AT$h\h${g}:$w$dir\n${g}║ $B\n${g}╚ $p$P$x "

  if (( ${#countme} > PROMPT_MAX )); then
    PS1="$double"
  elif (( ${#countme} > PROMPT_LONG )); then
    PS1="$long"
  else
    PS1="$short"
  fi
}

PROMPT_COMMAND="__ps1"

# --------------------------- my tools ---------------------------
for file in $SCRIPTS/*.sh; do
    . $file
done

# EOF

