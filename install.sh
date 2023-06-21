#!/usr/bin/env bash

EXEC_DIR=$(pwd)
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR

find . -name ".DS_Store" -exec rm {} \;
/opt/homebrew/bin/stow -v --target=$HOME bash other

source ~/.bashrc
cd $EXEC_DIR
